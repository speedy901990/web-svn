class HooksController < ApplicationController
  def new
     @hook = Hook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hook }
    end
  end

  def create #TODO
     @repository = Repository.new(params[:repository])
    if @repository.save
      #par = params[:repository]
      par = params[:repository][:repo_name]
      @result = %x[script/create_repo.sh #{par}]
      redirect_to :controller => 'home', :action => 'index'
    else
      render "new"
    end
  end

  def index
    @hook = Hook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hook }
    end
  end

  def destroy
    @hook = Hook.find(params[:id])
    @hook.destroy

    respond_to do |format|
      format.html { redirect_to repositories_path }
      format.json { head :no_content }
    end
  end

  def show
    @myfile = File.read("repositories/kurwa/hooks/post-commit.tmpl")
    
    # @hook = Hook.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @hook }
    #end
  end

  def update
     @hook = Hook.find(params[:id])

    respond_to do |format|
      if @hook.update_attributes(params[:repository])
        format.html { redirect_to hooks_path, notice: 'Hook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hook.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @hook = Hook.find(params[:id])
  end
end
