class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:user])
    if @group.save
      redirect_to root_url, :notice => "Group created!"
    else
      render "new"
    end
  end
end
