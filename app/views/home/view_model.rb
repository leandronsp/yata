class HomeViewModel
  def self.show(email = nil, tasks = [])
    if email
      content =
        File
        .read('./app/views/home/authenticated.html')
        .gsub("\n", " ")

      content.gsub("{{email}}", email)

      if matched = content.match(/<y-each-tasks>(.*?)<\/y-each-tasks>/)
        html_result = tasks.map do |task|
          matched[1].strip.gsub("{{task.name}}", task.name)
        end

        if html_result.any?
          content =
            content.gsub(/<y-each-tasks>.*?<\/y-each-tasks>/, html_result.join)
        else
          content =
            content.gsub(/<y-each-tasks>.*?<\/y-each-tasks>/, "")
        end
      end

      content.gsub("{{email}}", email)
    else
      File.read('./app/views/home/guest.html')
    end
  end
end
