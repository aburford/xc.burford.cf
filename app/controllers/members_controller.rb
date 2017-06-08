class MembersController < ApplicationController
	def new

	end

	def index
		@all_members = Member.order(grade: :desc, firstname: :asc).all
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
