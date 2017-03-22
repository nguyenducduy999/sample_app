class Supports::User
  def initialize current_user, user
    @current_user = current_user
    @user = user
  end

  def create_unfollow
    @current_user.active_relationships.find_by followed_id: @user.id
  end

  def create_follow
    @current_user.active_relationships.build
  end

  def find_followed
    @user_followed = @current_user.active_relationships.
      find_by followed_id: @user.id
  end
end
