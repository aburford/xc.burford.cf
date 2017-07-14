class Run < ApplicationRecord
	belongs_to :member
	validates :date, uniqueness: { scope: :member_id }
end
