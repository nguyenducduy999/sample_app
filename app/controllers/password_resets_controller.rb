class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration,
    only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "email_send_with_password"
      redirect_to root_url
    else
      flash.now[:danger] = t "email_not_found"
      render :new
    end
  end

   def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("cant_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t "sucsess"
      redirect_to @user
    else
      render :edit
    end
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]
    unless @user
    flash[:danger] = t "user_not_found"
    end
  end

  def valid_user
    unless @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
      flash[:danger] = t "account_don't_validate"
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "password_expire"
      redirect_to new_password_reset_url
    end
  end
end
