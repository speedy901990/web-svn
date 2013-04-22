class GrouptoreposController < ApplicationController
  def new
    @grouptorepo = Grouptorepo.new
  end

  def create
    @grouptorepo = Grouptorepo.new(params[:grouptorepo])
    if @grouptorepo.save
      redirect_to root_url, :notice => "Group to repo relation created!"
    else
      render "new"
    end
  end

  def show
  end

 def destroy    
   @repotogroup = Grouptorepo.find(params[:repository_id])
   @repotogroup.destroy
   respond_to do |format|	
     format.html { redirect_to repositories_path }
     format.json { head :no_content }
   end
 end
end
