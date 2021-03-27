require './app/views/template_engine'

class SpaViewModel
  def self.show
    raw_content = File.read('./app/views/spa/show.html').gsub("\n", " ")

    engine = TemplateEngine.new(raw_content)

    engine.render
  end
end
