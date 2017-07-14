class MembersController < ApplicationController
	def new

	end

	def download
		require 'csv'
		CSV.open("app/assets/data/emails.csv", "wb") do |csv|
			csv << %w(Name Email Grade)
			Member.order(grade: :desc, firstname: :asc).all.each do |m|
				csv << [m.name, m.email, m.grade]
			end
		end
		send_file "#{Rails.root}/app/assets/data/emails.csv", x_sendfile: true
	end

	def index
		mem = Member.order(grade: :desc, firstname: :asc).all
		@mail = "mailto:"
		mem.each do |m|
			@mail += m.email + ","
		end
		@all_members = mem
	end

	def show
		@member = Member.find(params[:id])
	end

	def create
		@member = Member.new(member_params)
  	@member.save
  	redirect_to @member
	end

	private
  def member_params
    params.require(:member).permit(:firstname, :lastname, :email, :grade)
  end
end
