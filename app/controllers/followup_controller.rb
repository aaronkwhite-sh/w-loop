class FollowupController < ApplicationController
  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :authenticate_user!
  #before_action :correct_user,   only: :destroy

  def create
    @followup = Followup.new
    @followup.user_id = params[:user_id]
    @followup.micropost_id = params[:micropost_id]
    @followup.done = params[:done]
    namestuff = params[:feed_user]
    if Followup.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id], :done => true).present?
      Followup.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id]).destroy_all
      flash[:notice] = "This action request has been reset, " + namestuff
      redirect_to root_url
    elsif Followup.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id], :done => nil).present?
      Followup.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id]).destroy_all
      @followup.save
      flash[:notice] = "This action has been completed, " + namestuff + "!"
      redirect_to root_url
    else
      if @followup.save
      flash[:success] = "This needs to be followed up, " + namestuff + "!"
      redirect_to root_url
      else
      #@feed_items = []
      flash[:notice] = "Oops.. Something went wrong"
      redirect_to root_url
      #render 'static_pages/home'
      end
    end
  end

  def edit
  end

  def update
    if @followup.update_attributes(params)
      flash[:success] = "Updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @followup.destroy
    redirect_to root_url
  end
end

  private

    def followup_params
      params.require(:followup).permit(:done)
      #add other params
    end
