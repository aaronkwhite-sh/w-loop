class MetooController < ApplicationController
  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :authenticate_user!
  #before_action :correct_user,   only: :destroy

  def create
    @metoo = Metoo.new
    @metoo.user_id = params[:user_id]
    @metoo.micropost_id = params[:micropost_id]
    namestuff = params[:feed_user]
    if Metoo.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id]).present?
      flash[:notice] = "You have un-me too'ed " + namestuff + "'s Post!"
      Metoo.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id]).destroy_all
      redirect_to root_url
    else
      if @metoo.save
      flash[:success] = "Me too'ed " + namestuff + "'s Post!"
      redirect_to root_url
      else
      #@feed_items = []
      flash[:notice] = "Oops.. Something went wrong"
      redirect_to root_url
      #render 'static_pages/home'
      end
    end
  end

  def destroy
    @metoo.destroy
    redirect_to root_url
  end
end
