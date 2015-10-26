class SalesforceEmailTemplateService
  attr_reader :template_body, :object_data

  def initialize template_body, object_data
    @template_body = template_body
    @object_data = object_data
  end

  def get_merge_fields
    {}
  end

  def render
    m = Mustache.new
    m.raise_on_context_miss = true
    m.render("{{={! } }} #{template_body}", object_data)
  end
end
