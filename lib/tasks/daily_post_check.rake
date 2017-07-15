require 'active_support/duration'
namespace :post_check do
	task midnight: [:environment] do
		save_runs(Date.today, 0)
		save_prev_days
		calculations
	end

	task afternoon: [:environment] do
		save_prev_days
		calculations
	end

	def save_prev_days
		(1..5).each do |days_late|
			save_runs(Date.today - days_late, days_late)
		end
	end

	def find_attr(body, name, eov = nil)
		s = body.index(name)
		return unless s
		body.slice!(0..s + name.length - 1)
		if eov
			e = body.index(eov)
			return body[0..e - 1] if e
		end
		body # eov was not found so return rest of the body
	end

	def save_runs(date, days_late)
		i = date.sunday? ? 7 : date.wday
		auth = "01017648C54358C8D408FE76088CBC29E7D508000942007500720066006F007200640061006E0000012F00FF"
		@doc = Nokogiri::HTML(HTTP.cookies(:sqlAuthCookie => auth).get("http://www.logarun.com/TeamCalendar.aspx?teamid=743&date=#{date.strftime('%m-%d-%Y')}").to_s) if @doc && date.sunday? || @doc.nil?
		@doc.css(".monthDay:nth-of-type(#{i})").each do |post|
			title = post.at_css('.dayTitle').content
			body = post.at_css('p')
			if body
				body = body.content
				dist = find_attr(body, 'Run: ', ' ')
				dist = find_attr(body, '(', ' ') if dist && body[dist.length + 5] == ',' # multiple dists were logged
				dur = find_attr(body, 'Run Time: ', 'R')
				dur = find_attr(body, '(', ')') if dur && dur.length > 8 # multiple durs were logged
				# find duration in seconds
				dur &&= ActiveSupport::Duration.parse("P0Y0M0DT0#{[dur.split(':'), %w(H M S)].transpose.flatten.join}").to_i
				note = find_attr(body, 'Note: ')
			end
			m = Member.find_by(username: post.at_css('.dayNum')['href'].split('/')[1])
			if m && (!title.empty? || body)
				Run.new(distance: dist.to_f, duration: dur || '0', title: title, note: note || '', date: date, member_id: m.id, days_late: days_late).save
			end
		end
	end

	# this task is for development/testing purposes only; it shouldn't be used in production
	task recalculate: [:environment] do
		calculations
	end

	def calculations
		dist = 0
		dur = 0
		Run.where("distance != 0 OR duration != 0").each do |r|
			dist += r.distance
			dur += r.duration
		end
		vals = Calculation.all_vals false
		vals[:tot_dist].set dist.round(2)
		vals[:avg_dist].set (dist / Run.where.not(distance: 0).count).round(2)
		vals[:tot_dur].set dur
		vals[:avg_dur].set (dur / Run.where.not(duration: 0).count.to_f).round(2)
		d = 0
		t = 0
		Run.where("distance != 0 AND duration != 0").each do |r|
			d += r.distance
			t += r.duration
		end
		vals[:avg_pace].set (t / d).round(2)
	end
end