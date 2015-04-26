class UsersController < ApplicationController
	def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(users_params)
    if @user.save
    	@user.username = params[:username]
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up"
    else
      flash.now[:alert] = "Error in email or password"
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
    flash[:notice] = "Your user has been updated"
    redirect_to root_path
    else
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Your user has been deleted"
    redirect_to root_path
  end

private

  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end