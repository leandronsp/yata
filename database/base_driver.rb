class BaseDriver
  def self.driver(config)
    config_as_symbols = config.transform_keys(&:to_sym)
    @driver ||= new(config_as_symbols)
  end

  def createdb; end
  def dropdb; end
  def migratedb; end
  def truncatedb; end
end
