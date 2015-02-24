class StaticPagesController < ApplicationController

  def home
    if logged_in?
        @travel_route = current_user.travel_routes.build
        @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def jobs
  end

  def login
  end

end
