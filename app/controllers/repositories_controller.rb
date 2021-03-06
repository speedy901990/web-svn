class RepositoriesController < ApplicationController
  def new
    @repository = Repository.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repository }
    end
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
    @repository = Repository.new(params[:repository])
      if @repository.save
        fileUpdate
        par = params[:repository][:repo_name]
        @result = %x[script/create_repo.sh #{par}]
        redirect_to repositories_path
      else
        render "new"
      end
  end

  def index
    @repositories = Repository.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repositories }
    end
  end

  def destroy    
    @repository = Repository.find(params[:id])
    @repository.destroy
    fileUpdate
    # par = params[:repository][:repo_name]
    par = @repository.repo_name
    @result = %x[script/delete_repo.sh #{par}]

    respond_to do |format|	
      format.html { redirect_to repositories_path }
      format.json { head :no_content }
    end
  end
  def edit
    @repository = Repository.find(params[:id])
  end

  def show
    @repository = Repository.find(params[:id])
    @hooksList = %x[ls repositories/#{@repository.repo_name}/hooks/] #.split("\n")
    
    if (@repository != nil)
      @gtr = Grouptorepo.where("repository_id = ?", params[:id]).select("group_id").first
    end
    
    if (@gtr != nil)
      @x = Group.where("id = ?", @gtr.group_id).select("group_name").first
    end
    
    if (@gtr != nil)
      @usr = Usertogroup.where("group_id = ?", @gtr.group_id).all
    end 
    
    @htr = Hook.all
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repository }
    end
  end
  
  def update
    @repository = Repository.find(params[:id])
    par1 = params[:repository][:repo_name]
    
    
    respond_to do |format|
      if @repository.update_attributes(params[:repository])
        fileUpdate
        par2 = params[:repository][:repo_name]
        @result = %x[script/rename_repo.sh #{par1} #{par2}]
        format.html { redirect_to repositories_path, notice: 'Repository was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end
end
