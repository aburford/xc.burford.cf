class Member < ApplicationRecord
	include ApplicationHelper
	has_many :runs
	has_many :mem_calcs

	FIRST_DAY = Date.new(2017,6,15) # the first day of the 2017 xc season (first day of summer)

	def name
		"#{firstname} #{lastname}"
	end

	def calcs
		vals = {}
  	keys = MemCalc::CALC_TYPE.to_enum
  	mem_calcs.each {|v| vals[keys.next] = v.value}
  	vals[:avg_dur] = format_pace vals[:avg_dur]
  	vals[:avg_pace] = format_pace vals[:avg_pace]
  	vals
	end

	def log_freq
		# runs.where("date > '#{FIRST_DAY}'").count / (Day.today - FIRST_DAY)
		format_perc(runs.where("date >= '2017-06-15'").count / (Date.today - FIRST_DAY).to_f)
	end

	def logged_yesterday?
		runs.exists?(date: Date.today.prev_day)
	end

	# returns an array of how many days late this member was on the logs for the previous 5 days
	def days_late
		days = []
		(1..5).each do |ago|
			r = runs.where(date: Date.today - ago).first
			late = r.days_late == 0 ? 'On time' : r.days_late if r
			late ||= 'NO LOG'
			days << late
		end
		days
	end

end
