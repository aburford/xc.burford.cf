require 'active_support/duration'
class Stats::StatsController < ApplicationController
	def index
		# dist = 0
		# dur = 0
		# runs = Run.where("distance != 0 OR duration != 0")
		# runs.each do |r|
		# 	dist += r.distance
		# 	dur += r.duration
		# end
		# dist = dist.round 2		
		# @dist_avg = dist / Run.where.not(distance: 0).count
		# @dur_avg = dur / Run.where.not(duration: 0).count
		# @tot_dist = dist
		# @tot_dur = dur
		# d = 0
		# t = 0
		# Run.where("distance != 0 AND duration != 0").each do |r|
		# 	logger.debug "distance or duration is zero" if r.distance == 0 || r.duration == 0
		# 	d += r.distance
		# 	t += r.duration
		# end
		# p = t / d
		# @pace_avg = "#{(p / 60).round}:#{(p % 60).round}"
		@vals = TeamCalc.all_vals true
	end

	def logarun
		@days = []
		(1..5).each do |ago|
			slackers = []
			Member.all.each {|m| slackers << m.name unless m.runs.exists?(date: Date.today - ago)}
			@days[ago - 1] = [Run.where(date: Date.today - ago).order(:days_late), slackers]
		end
	end

	def members
	end
end
