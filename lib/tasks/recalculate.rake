namespace :recalculate do
	task all_members: [:environment] do
		Member.all.each { |m| MemCalc.recalc(m)}
	end

	task team: [:environment] do
		dist = 0
		dur = 0
		Run.where("distance != 0 OR duration != 0").each do |r|
			dist += r.distance
			dur += r.duration
		end
		vals = TeamCalc.all_vals false
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
