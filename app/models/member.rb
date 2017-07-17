class Member < ApplicationRecord

	has_many :runs
	has_many :mem_calcs

	def name
		"#{firstname} #{lastname}"
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
