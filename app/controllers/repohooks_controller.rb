class RepohooksController < ApplicationController
   def new
    @repohook = Repohook.new
  end

  def create
    @repohook = Repohook.new(params[:repohook])
    if @repohook.save
      redirect_to root_url, :notice => "Repohook relation created!"
    else
      render "new"
    end
  end
  
 def destroy    
   @repohook = Repohook.find(params[:id])
   @repohook.destroy
   respond_to do |format| 
     format.html { redirect_to repositories_path }
     format.json { head :no_content }
   end
 end

def index
    @repohook = Repohook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repohook }
    end
  end

 def edit
    @repohook = Repohook.find(params[:id])
  end

  def show
    @repohook = Repohook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repohook }
    end
  end
  
  def update
    @repohook = Repohook.find(params[:id])

    respond_to do |format|
      if @repohook.update_attributes(params[:repository])
        format.html { redirect_to hooktorepos_path, notice: 'Repohook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repohook.errors, status: :unprocessable_entity }
      end
    end
  end

end