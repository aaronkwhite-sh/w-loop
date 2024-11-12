class FavoriteController < ApplicationController
  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :authenticate_user!
  #before_action :correct_user,   only: :destroy

  def create
    @favorite = Favorite.new
    @favorite.user_id = params[:user_id]
    @favorite.micropost_id = params[:micropost_id]
    namestuff = params[:feed_user]
    if Favorite.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id]).present?
      flash[:notice] = "You have un-watched " + namestuff + "'s Post!"
      Favorite.where(:user_id => params[:user_id], :micropost_id => params[:micropost_id]).destroy_all
      redirect_to root_url
    else
      if @favorite.save
      flash[:success] = "Watched " + namestuff + "'s Post!"
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
    @favorite.destroy
    redirect_to root_url
  end
end
