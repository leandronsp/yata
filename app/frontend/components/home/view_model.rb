require './app/frontend/template_engine'

class HomeViewModel
  def self.show(email, tasks)
    raw_content = File.read('./app/frontend/components/home/index.html').gsub("\n", " ")

    engine = TemplateEngine.new(raw_content)

    engine.apply_substitution!("{{email}}", email)

    engine.apply_tag_substitution!("y-each-tasks") do |html_part|
      tasks.map do |task|
        html_part
          .gsub("{{task.name}}", task.name)
          .gsub("{{task.id}}", task.name)
      end.join
    end

    engine.render
  end
end
