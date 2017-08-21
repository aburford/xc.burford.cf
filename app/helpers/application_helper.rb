module ApplicationHelper
	def format_pace(seconds)
		"#{(seconds.round / 60)}:#{(seconds % 60).round.to_s.rjust(2, '0')}"
	end

	def format_perc(decimal)
		"#{(decimal * 100).round 2}%"
	end

end
