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
      redirect_to root_url
    else
      render "new"
    end
  end
  def delete_repo
  end
end
