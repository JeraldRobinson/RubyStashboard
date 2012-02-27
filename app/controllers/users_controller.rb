class UsersController < ApplicationController
  before_filter :find_user_by_id, only: [:show, :edit, :update]
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:show, :edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def index
    @user=current_user
    if @user.admin?
      @users = User.paginate(page: params[:page])
    else
      redirect_to services_path
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to services_path
    else
      render :new
    end
  end

  def show
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success]="Updated user successfully"
      render :show
    else
      render :edit
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private
  
  def find_user_by_id
    @user=User.find(params[:id])
  end
  
  def correct_user
    redirect_to(services_path) unless current_user?(@user) or current_user.admin?
  end
  
  def admin_user
    redirect_to(services_path) unless current_user.admin?
  end
  
  
end
