class HooksController < ApplicationController
  def new
     @hook = Hook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hook }
    end
  end

  def create #TODO
     @hook = Hook.new(params[:hook])
    if @hook.save
      redirect_to hooks_path
    else
      render "new"
    end
  end

  def index
    @hooks = Hook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hook }
    end
  end

  def destroy
    @hook = Hook.find(params[:id])
    @hook.destroy

    respond_to do |format|
      format.html { redirect_to hooks_path }
      format.json { head :no_content }
    end
  end

  def show
    @hook = Hook.find(params[:id])
   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hook }
    end 
  end

  def edit
    @hook = Hook.find(params[:id])
  end

  def update
     @hook = Hook.find(params[:id])

    respond_to do |format|
      if @hook.update_attributes(params[:hook])
        format.html { redirect_to hooks_path, notice: 'Hook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hook.errors, status: :unprocessable_entity }
      end
    end
  end

  def saveusage
    @myfile1 = File.open("repositories/" + params[:repo_name] + "/hooks/" + params[:hook_name], "w")
      @myfile1.puts(params[:message])
      @myfile1.close()
      
    redirect_to hooks_path
  end

  def use
    @templateHook = Hook.where("hook_name = ?", params[:hook_name]).first.script
    
    @newScriptFile = File.open("repositories/" + params[:repo_name] + "/hooks/" + params[:hook_name], "w")
    @newScriptFile.puts(@templateHook)
    @newScriptFile.close()
    
    @myfile = File.read("repositories/" + params[:repo_name] + "/hooks/" + params[:hook_name])
    
    @repo_name = params[:repo_name]
    @hook_name = params[:hook_name]
  
  end
  
  def edituserhook
    @myfile = File.read("repositories/" + params[:repo_name] + "/hooks/" + params[:hook_name])
    
    @repo_name = params[:repo_name]
    @hook_name = params[:hook_name]
  end
  
  def showuserhook
    @repo_name = params[:repo_name]
    @hook_name = params[:hook_name]
    @script = File.read("repositories/" + params[:repo_name] + "/hooks/" + params[:hook_name])
  end
  
end
