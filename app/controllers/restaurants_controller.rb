class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurants_params.merge(user_id: current_user.id))
    if @restaurant.valid?
      redirect_to restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurants_params)
      redirect_to root_url
      flash[:notice] = "Your restaurant has been updated"
    else
      redirect_to edit_restaurant_path(@restaurant)
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "Your restaurant has been deleted"
    redirect_to root_path
  end


private

  def restaurants_params
    params.require(:restaurant).permit(:user_id, :name, :description, :address, :website, :zip)
  end
end