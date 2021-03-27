require './app/frontend/template_engine'

class ViewModelBase
  def self.content(path)
    define_method(:initialize) do
      raw_content = File.read(path).gsub("\n", " ")
      engine      = TemplateEngine.new(raw_content)

      instance_variable_set(:@engine, engine)
    end
  end

  def self.method_missing(m, *args, &block)
    instance = new
    instance.send(m.to_sym, *args, &block)
    instance.render
  end

  def apply_substitution(raw_value, new_value)
    @engine.apply_substitution!(raw_value, new_value)
  end

  def apply_tag_substitution(tag, &block)
    @engine.apply_tag_substitution!(tag, &block)
  end

  def render
    @engine.render
  end
end
