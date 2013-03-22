class RepositoriesController < ApplicationController
  def create_repo
  	@repo_name = String(params[:repo_name])
  	@path = "repositories/" + @repo_name
  	@result = %x[svnadmin create @path]
  end
end
