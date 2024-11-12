class SearchController < ApplicationController

  def filter
  end

  def usersearch
    if signed_in?
      @users = User.all
    if params["usersearch"] != ""
      @usersearch_items = User.partial_usersearch(params["usersearch"])
    else
      @usersearch_items = nil
    end
  end
  end

  def search
  if signed_in?

    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
	  @fav_items = current_user.favs
      @metoo_items = current_user.metoos
      @followup_items = current_user.followups

    if params["search"] != ""
    	@search_items = Micropost.partial_search(params["search"])
	   else
	     @search_items = nil
	   end
  
    
  
  end
end 

end