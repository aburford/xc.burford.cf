class Member < ApplicationRecord

	has_many :runs
	has_many :mem_calcs

	def name
		"#{firstname} #{lastname}"
	end

	def logged_yesterday?
		runs.exists?(date: Date.today.prev_day)
	end
	
end
