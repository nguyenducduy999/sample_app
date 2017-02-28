class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
    @users = @user.send(params[:type])
  end

  def create
    @user = User.find_by id: params[:followed_id]
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
    current_user.follow @user
    @supports = Supports::User.new current_user, @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @supports = Supports::User.new current_user, @user
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
