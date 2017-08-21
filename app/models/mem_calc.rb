class MemCalc < ApplicationRecord
  include ApplicationHelper
  belongs_to :member

	validates :calc_type, uniqueness: { scope: :member_id }

  CALC_TYPE = [:tot_dist, :tot_dur, :avg_dist, :avg_dur, :avg_pace].freeze

  def self.vals_for(mem)
  	vals = {}
  	keys = CALC_TYPE.to_enum
  	mem.mem_calcs.each {|v| vals[keys.next] = v.value}
  	vals[:avg_dur] = format_pace vals[:avg_dur]
  	vals[:avg_pace] = format_pace vals[:avg_pace]
  	vals
	end

	def set(val)
		self[:value] = val
		save
	end

	def self.recalc(mem)
		dist = 0
		dur = 0
		mem.runs.where("distance != 0 OR duration != 0").each do |r|
			dist += r.distance
			dur += r.duration
		end
		avg_dist = (dist / mem.runs.where.not(distance: 0).count).round 2 unless dist.zero?
		avg_dist ||= 0
		avg_dur = (dur / mem.runs.where.not(duration: 0).count.to_f).round 2 unless dur.zero?
		avg_dur ||= 0
		d = 0
		t = 0
		mem.runs.where("distance != 0 AND duration != 0").each do |r|
			d += r.distance
			t += r.duration
		end
		avg_pace = (t / d).round(2) unless d.zero?
		avg_pace ||= 0
		calcs = mem.mem_calcs.order(:calc_type)
		calcs[CALC_TYPE.index(:tot_dist)].set dist
		calcs[CALC_TYPE.index(:tot_dur)].set dur
		calcs[CALC_TYPE.index(:avg_dist)].set avg_dist
		calcs[CALC_TYPE.index(:avg_dur)].set avg_dur
		calcs[CALC_TYPE.index(:avg_pace)].set avg_pace
	end

end
