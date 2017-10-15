class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  # def create
  #   @user = User.create(name: params[:name])
  #   # @user = User.new(user_params)
  #   # if @user.save
  #   unless @user.id == nil
  #     session[:user_id] = @user.id
  #     flash[:status] = :success
  #     flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
  #     redirect_to root_path
  #   else
  #     flash[:status] = :error
  #     flash[:message] = "did not succesfully login"
  #     render "login" #should go back to login page
  #   end
  # end

  def login_form
  end

  def login
    if User.find_by_name(params[:name]) != nil
      @user = User.find_by_name(params[:name])
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.create(name: params["name"])
      # @user = User.new(user_params)
      # if @user.save
      unless @user.id == nil
        session[:user_id] = @user.id
        flash[:status] = :success
        flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
        redirect_to root_path
      else
        flash[:status] = :error
        flash[:message] = "did not succesfully login"
        render "login"
      end

    end
  end


  private
    def user_params
      params.require(:user).permit(:name)
    end
end
