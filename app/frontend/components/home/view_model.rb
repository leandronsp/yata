require './app/frontend/view_model_base'

class HomeViewModel < ViewModelBase
  content './app/frontend/components/home/index.html'

  def show(email, tasks)
    apply_substitution("{{email}}", email)

    apply_tag_substitution("y-each-tasks") do |html_part|
      tasks.map do |task|
        html_part
          .gsub("{{task.name}}", task.name)
          .gsub("{{task.id}}", task.name)
      end.join
    end
  end
end
