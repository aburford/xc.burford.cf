task copy_data: [:environment] do
	day = Date.today - 3
	auth = "01017648C54358C8D408FE76088CBC29E7D508000942007500720066006F007200640061006E0000012F00FF"
	while day > Date.new(2017, 7, 9)
		puts "loading logarun for date: #{day}..."
		doc = Nokogiri::HTML(HTTP.cookies(:sqlAuthCookie => auth).get("http://www.logarun.com/TeamCalendar.aspx?teamid=743&date=#{day.strftime('%m-%d-%Y')}").to_s)
		(2..8).each do |i|
			puts "finding #{i - 1}-th day and date: #{day}"
			doc.css(".monthDay:nth-child(#{i})").each do |post|
				# iterates through each post today from the team
				title = post.at_css('.dayTitle').content
				body = post.at_css('p')
				if body
					body = body.content
					dist = find_attr(body, 'Run: ', ' ')
					dist = find_attr(body, '(', ' ') if dist && body[dist.length + 5] == ',' # multiple dists were logged
					dur = find_attr(body, 'Run Time: ', 'R') || '00:00:00'
					dur = find_attr(body, '(', ')') if dur && dur.length > 8 # multiple durs were logged
					# find duration in seconds
					dur &&= ActiveSupport::Duration.parse("P0Y0M0DT0#{[dur.split(':'), %w(H M S)].transpose.flatten.join}").to_i
					note = find_attr(body, 'Note: ')
				end
				m = Member.find_by(username: post.at_css('.dayNum')['href'].split('/')[1])
				if m && (!title.empty? || body)
					puts Run.new(distance: dist.to_f, duration: dur, title: title, note: note, date: day, member_id: m.id).save
				end
			end
			day = day.next_day
		end
		day = day.prev_week.prev_week
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