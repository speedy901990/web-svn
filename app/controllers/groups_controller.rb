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
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|	
      format.html { redirect_to repositories_path }
      format.json { head :no_content }
    end
  end
end
