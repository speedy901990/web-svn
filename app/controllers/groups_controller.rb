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
      format.html { redirect_to groups_path }
      format.json { head :no_content }
    end
  end

  def index
    @group = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group }
    end
  end

def edit
    @group = Group.find(params[:id])
  end

  def show
    @group = Group.find(params[:id])
    @gtr = Usertogroup.where("group_id = ?", params[:id]).select("user_id").first
    @x = User.where("id = ?", @gtr.user_id).select("email").first
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end
  
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to groups_path, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


end
