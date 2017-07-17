class TeamCalc < ApplicationRecord
	
	attr_accessor :value

	TEAM_CALC_ID = {:tot_dist => 1, :tot_dur => 2, :avg_dist => 3, :avg_dur => 4, :avg_pace => 5}.freeze

	def self.[](type)
		v = find(TEAM_CALC_ID[type]).value
		return format_pace(v) if type == :avg_dur || :avg_pace
		v
	end

	def set(val)
		self[:value] = val
		save
	end

	# used to display the calculations
	def self.all_vals(formatted)
		vals = {}
		keys = TEAM_CALC_ID.dup.keys.to_enum
		if formatted
			TeamCalc.all.each { |c| vals[keys.next] = c[:value] }
			vals[:avg_pace] = format_pace vals[:avg_pace]
			vals[:avg_dur] = format_pace vals[:avg_dur]
		else
			TeamCalc.all.each { |c| vals[keys.next] = c}
		end
		vals
	end

	private

	def self.format_pace(seconds)
		"#{(seconds / 60).round}:#{(seconds % 60).round.to_s.rjust(2, '0')}"
	end
end
