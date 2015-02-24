class TravelRoutesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @travel_route = current_user.travel_routes.build(travel_route_params)
        if @travel_route.save
            flash[:success] = "Route created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end

    def destroy
        @travel_route.destroy
        flash[:success] = "Travel Route deleted"
        redirect_to request.referrer || root_url
    end

    private
        
        def travel_route_params
            params.require(:travel_route).permit(:start_long, :end_long, :start_lat, :end_lat, :distance, :price)
        end

        def correct_user
            @travel_route = current_user.travel_routes.find_by(id: params[:id])
            redirect_to root_url if @travel_route.nil?
        end
end
