class UsertogroupsController < ApplicationController
  def new
    @usertogroup = Usertogroup.new
  end

  def fileUpdate
    @configFile = File.open("config/apache_config/authz","w")
      @allGroups = Group.all
      @allRepos = Repository.all

      @configFile.write("[groups]\n")

      @allGroups.each do |f|
        @usersInGroup = Usertogroup.where("group_id = ?", f.id).all
        if (@usersInGroup != nil)
          @configFile.write(f.group_name + " = ")
          
          @usersInGroup.each do |g|
            @usr = User.where("id = ?", g.user_id).first
            @configFile.write(@usr.email + ", ")
          end
        end
        @configFile.write("\n")
      end

      @configFile.write("\n")
      @allRepos.each do |f|
        @configFile.write("# Project " + f.repo_name + "\n")
        @configFile.write("[" + f.repo_name + ":/]" + "\n")
        @groupsToRepos = Grouptorepo.where("repository_id = ?", f.id).all
        if (@groupsToRepos != nil)
          @groupsToRepos.each do |g|
            @group = Group.where("id = ?", g.group_id).first
            @configFile.write("@" + @group.group_name + " = ")
            if g.r == true
              @configFile.write("r")
            end
            if g.w == true
              @configFile.write("w")    
            end
            @configFile.write("\n")    
          end
        end
        @configFile.write("\n")
        end
      @configFile.close()

  end

  def create
    @usertogroup = Usertogroup.new(params[:usertogroup])
    if @usertogroup.save
      fileUpdate
      redirect_to root_url, :notice => "User to group relation created!"
    else
      render "new"
    end
  end
  
 def destroy    
   @usertogroup = Usertogroup.find(params[:group_id])
   @usertogroup.destroy
   respond_to do |format| 
     format.html { redirect_to groups_path }
     format.json { head :no_content }
   end
 end

def index
    @usertogroup = Usertogroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usertogroup }
    end
  end

 def edit
    @usertogroup = Usertogroup.find(params[:id])
  end

  def show
    @usertogroup = Usertogroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usertogroup }
    end
  end
  
  def update
    @usertogroup = Usertogroup.find(params[:id])

    respond_to do |format|
      if @usertogroup.update_attributes(params[:group])
        format.html { redirect_to usetrogroups_path, notice: 'Usertogroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usertogroup.errors, status: :unprocessable_entity }
      end
    end
  end

end
