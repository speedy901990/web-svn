class HooktoreposController < ApplicationController
   def new
    @hooktorepo = Hooktorepo.new
  end

  def create
    @hooktorepo = Hooktorepo.new(params[:hooktorepo])
    if @hooktorepo.save
      redirect_to root_url, :notice => "Hook to repo relation created!"
    else
      render "new"
    end
  end
  
 def destroy    
   @hooktorepo = Hooktorepo.find(params[:repository_id])
   @hooktorepo.destroy
   respond_to do |format| 
     format.html { redirect_to repositories_path }
     format.json { head :no_content }
   end
 end

def index
    @hooktorepo = Hooktorepo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hooktorepo }
    end
  end

 def edit
    @hooktorepo = Hooktorepo.find(params[:id])
  end

  def show
    @hooktorepo = Hooktorepo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hooktorepo }
    end
  end
  
  def update
    @hooktorepo = Hooktorepo.find(params[:id])

    respond_to do |format|
      if @hooktorepo.update_attributes(params[:repository])
        format.html { redirect_to hooktorepos_path, notice: 'Hooktorepo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hooktorepo.errors, status: :unprocessable_entity }
      end
    end
  end

end
