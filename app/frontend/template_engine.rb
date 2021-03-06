class TemplateEngine
  def initialize(content)
    @content = content.dup
  end

  def render
    @content
  end

  def apply_substitution!(original_value, new_value)
    @content.gsub!(original_value, new_value)
  end

  def apply_tag_substitution!(tag_name)
    regex_substitution_tag = /<#{tag_name}>(.*?)<\/#{tag_name}>/

    if matched = @content.match(regex_substitution_tag)
      html_result = yield(matched[1].strip)

      @content.gsub!(regex_substitution_tag, html_result)
    end
  end

  def render_partial!(tag_name)
    regex_substitution_tag = /<#{tag_name}>(.*?)<\/#{tag_name}>/

    if matched = @content.match(regex_substitution_tag)
      html_result = yield(matched[1].strip)
      @content = html_result
    end
  end
end
