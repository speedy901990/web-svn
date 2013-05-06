class UsertogroupsController < ApplicationController
  def new
    @usertogroup = Usertogroup.new
  end

  def create
    @usertogroup = Usertogroup.new(params[:usertogroup])
    if @usertogroup.save
      redirect_to root_url, :notice => "User to group relation created!"
    else
      render "new"
    end
  end
  
 def destroy    
   @usertogroup = Usertogroup.find(params[:group_id])
   @usertogroup.destroy
   respond_to do |format| 
     format.html { redirect_to groups_path }
     format.json { head :no_content }
   end
 end

def index
    @usertogroup = Usertogroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usertogroup }
    end
  end

 def edit
    @usertogroup = Usertogroup.find(params[:id])
  end

  def show
    @usertogroup = Usertogroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usertogroup }
    end
  end
  
  def update
    @usertogroup = Usertogroup.find(params[:id])

    respond_to do |format|
      if @usertogroup.update_attributes(params[:group])
        format.html { redirect_to usetrogroups_path, notice: 'Usertogroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usertogroup.errors, status: :unprocessable_entity }
      end
    end
  end

end
