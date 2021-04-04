require './app/frontend/view_model_base'

class HomeViewModel < ViewModelBase
  content './app/frontend/components/home/index.html'

  def show(email, tasks)
    apply_substitution("{{email}}", email)

    apply_tag_substitution("y-each-tasks") do |html_part|
      build_tasks_data(html_part, tasks)
    end
  end

  def tasks_partial(tasks)
    render_partial("y-each-tasks") do |html_part|
      build_tasks_data(html_part, tasks)
    end
  end

  private

  def build_tasks_data(html, tasks)
    tasks.map do |task|
      html
        .gsub("{{task.name}}", task.name)
        .gsub("{{task.id}}", task.id)
    end.join
  end
end
