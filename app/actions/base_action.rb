class BaseAction
  def self.call(*args)
    new(*args).result
  end
end
