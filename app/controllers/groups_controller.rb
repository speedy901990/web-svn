class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to root_url, :notice => "Group created!"
    else
      render "new"
    end
  end

  def destroy

  end
end
