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
  	format.js {render :action => "alert('wyjebane');"}
  end
end
