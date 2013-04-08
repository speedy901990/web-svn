class RepositoriesController < ApplicationController
  def new
    @repository = Repository.new
  end
  def create    
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
    @repositories = Repository.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repositories }
    end
  end
end
