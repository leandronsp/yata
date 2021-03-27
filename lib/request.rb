require 'cgi'

class Request
  attr_reader :verb, :path, :params, :headers, :cookie

  def initialize(verb, path, params, headers, cookie)
    @verb, @path, @params, @headers, @cookie = verb, CGI.unescape(path), params, headers, cookie
  end

  def add_param(name, value)
    @params[name] = value
  end

  def static_asset?
    path_looks_like_static? && extension_looks_like_static?
  end

  def path_looks_like_static?
    @path.match?(/^\/public\/.*?/) || @path.match?(/^\/app\/frontend\/.*?/)
  end

  def extension_looks_like_static?
    @path.match?(/.*?\.(js|css)$/)
  end

  ## Removes the first character, "/"
  #  Examples:
  #  1) /public/yata.css becomes public/yata.css
  #  2) /public/nested/file.jpg becomes public/nested/file.jpg
  def static_asset_path
    return '' unless static_asset?

    @path[1..-1]
  end
end
