class MicropostsController < ApplicationController
  include Twitter::Extractor
  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :authenticate_user!
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    #usernames = extract_mentioned_screen_names("Mentioning @twitter and @jack")
    if @micropost.save
      flash[:success] = "Loop post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, {:areaofapparray => []}, :typeofcall, :company, :mood, :min)
      #add other params
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
