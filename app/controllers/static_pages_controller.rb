class StaticPagesController < ApplicationController
#before_action :authenticate_user!

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @search_items = nil
      @fav_items = current_user.favs
      @metoo_items = current_user.metoos
      @followup_items = current_user.followups
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
