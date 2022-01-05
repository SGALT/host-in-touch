module ApiFormHelper
  def api_input(resource, attribute, options={})
    simple_form_for(resource.type.singularize.to_sym) do |f|
      return f.input attribute, input_html: { value: resource.attributes[attribute] }
    end
  end
end
