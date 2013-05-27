class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def fileUpdate
          @configFile = File.open("config/apache_config/passwd","w")
      @allUsers = User.all
      
      @configFile.write("[users]\n")
      @allUsers.each do |f|
        @configFile.write(f.email + ":" + f.password_hash + "\n")
      end
      @configFile.close()

  end
  def create
    @user = User.new(params[:user])
    @existingUser = User.where("email = ?",@user.email)

    if @existingUser == nil
      if @user.save
        fileUpdate
        redirect_to root_url, :notice => "Signed up!"
      else
        render "new"
      end
    else
      redirect_to root_url, :notice => "User already exist!"
    end
  end

  def index
    @user = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  def destroy    
    @user = User.find(params[:id])
    @user.destroy
    fileUpdate
    respond_to do |format|  
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @gtr = Usertogroup.where("user_id = ?", params[:id]).select("group_id").first
    @x = Group.where("id = ?", @gtr.group_id).select("group_name").first
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        fileUpdate
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
