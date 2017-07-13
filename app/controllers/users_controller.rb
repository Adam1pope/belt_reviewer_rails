class UsersController < ApplicationController
  def index
    if session[:id].nil?
      render '/users/index'
    else
      redirect_to '/events'
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash[:errors] = ['User does not exist']
      redirect_to :back
    else
      if @user.password == params[:password]
        session[:id] = @user.id
        redirect_to '/events'
      else
        flash[:errors] = ['Password does not match']
        redirect_to :back
      end
    end
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to '/events'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      redirect_to '/events'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def logout
    reset_session
    redirect_to '/users'
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state)
    end
end
