class EmailsViewModel
  def self.render_create(params = {})
    "CRIADO\nEmail <#{params[:email]}> guardado com sucesso"
  end

  def self.render_show(params = {})
    "OK\n#{params[:email]}"
  end

  def self.render_not_found
    "NotFound"
  end
end
