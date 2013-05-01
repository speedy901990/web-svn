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
  
 def destroy    
   @grouptorepo = Grouptorepo.find(params[:repository_id])
   @grouptorepo.destroy
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
        format.html { redirect_to grouptorepos_path, notice: 'Grouptorepo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @grouptorepo.errors, status: :unprocessable_entity }
      end
    end
  end

end
