class HomeViewModel
  def self.show(email = nil)
    if email
      content = File.read('./app/views/home/authenticated.html')
      content.gsub("{{email}}", email)
    else
      File.read('./app/views/home/guest.html')
    end
  end
end
