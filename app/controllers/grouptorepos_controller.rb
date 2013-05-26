class GrouptoreposController < ApplicationController
  def new
    @grouptorepo = Grouptorepo.new
  end

def fileUpdate
      @configFile = File.open("config/apache_config/authz","w")
      @allRepos = Repository.all

      @allGroups = Group.all
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
            # @tempLine = "@" + @group.group_name + " = "
            @configFile.write("@" + @group.group_name + " = ")
            if g.r == true
              @configFile.write("r")
              # @tempLine = @tempLine + "r"  
            end
            if g.w == true
              @configFile.write("w")    
            #  @tempLine = @tempLine + "w"  
            end
            # @configFile.write(@tempLine)
            @configFile.write("\n")    
          end
        end
        @configFile.write("\n")
        end
      @configFile.close()

  end

  def create
    @grouptorepo = Grouptorepo.new(params[:grouptorepo])
    if @grouptorepo.save
      fileUpdate
      redirect_to root_url, :notice => "Group to repo relation created!"
    else
      render "new"
    end
  end
  
 def destroy    
   @grouptorepo = Grouptorepo.find(params[:repository_id])
   @grouptorepo.destroy
   fileUpdate
   respond_to do |format|	
     format.html { redirect_to repositories_path }
     format.json { head :no_content }
   end
 end

def index
    @grouptorepo = Grouptorepo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grouptorepo }
    end
  end

 def edit
    @grouptorepo = Grouptorepo.find(params[:id])
  end

  def show
    @grouptorepo = Grouptorepo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grouptorepo }
    end
  end
  
  def update
    @grouptorepo = Grouptorepo.find(params[:id])

    respond_to do |format|
      if @grouptorepo.update_attributes(params[:repository])
        fileUpdate
        format.html { redirect_to grouptorepos_path, notice: 'Grouptorepo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @grouptorepo.errors, status: :unprocessable_entity }
      end
    end
  end

end
