class UsermailinglistsController < ApplicationController
  def new
    @usermailinglist = Usermailinglist.new
  end

  def create
    @g = params[:group_id]
    @r = params[:repo_id]
    @users = Usertogroup.where("group_id = ?", @g).all #select("user_id").all

    @users.each do |f|
      @usermailinglist = Usermailinglist.new
      @usermailinglist.user_id = f.user_id
      @usermailinglist.repo_id = @r
      @usermailinglist.notification = false
      @usermailinglist.save
    end
        redirect_to repositories_path, :notice => "Relation Created!"
   end

  def edit
    @usermailinglist = Usermailinglist.find(params[:id])
  end

  def update
    @usermailinglist = Usermailinglist.find(params[:id])

    respond_to do |format|
      if @usermailinglist.update_attributes(params[:usermailinglist])
        format.html { redirect_to usermailinglists_path, notice: 'Mailing list updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usermailinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  end

  def destroy
    @usermailinglist = Usermailinglist.find(params[:id])
    @usermailinglist.destroy
    respond_to do |format|  
      format.html { redirect_to usermailinglists_path }
      format.json { head :no_content }
    end
  end
end
