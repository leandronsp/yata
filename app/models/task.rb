class Task
  attr_accessor :id, :name, :user

  def initialize(attrs = {})
    @id   = attrs[:id]
    @name = attrs[:name]
    @user = attrs[:user]
  end

  def user_id
    @user.id
  end

  def user_email
    @user.email
  end
end
