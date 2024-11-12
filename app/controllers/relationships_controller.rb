class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def followall
    @user = User.all
    @user.each do |userid|
      if current_user.following?(userid)
      else
       current_user.follow!(userid)
      end
    end
    redirect_to users_path
  end

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end