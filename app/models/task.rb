class Task
  attr_reader :user, :name

  def initialize(attrs = {})
    @user = attrs[:user]
    @name = attrs[:name]
  end

  def user_email
    @user.email
  end
end
