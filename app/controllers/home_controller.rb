class HomeController < ApplicationController
  def index
    if ! params[:template].present?
      params[:template] = %{Hello,
{!Contact.FirstName}, thanks for your message.
I'll call you ASAP at {!Contact.Phone}.

Sincerely,
{! Sender }
}
    end
    if ! params[:object_data]
      params[:object_data] = { "Contact" => { "FirstName" => "Tom", "Phone" => "111-222-1234"}, "Sender" => "Duke" }
    end
    if params[:new_field].present?
      def add( p, k, v)
        if v.class == Hash
          if p && p.has_key?(k) && p[k].class == ActionController::Parameters
            add( p[k], v.keys.first, v.values.first)
          else
            p[k] = add( {}, v.keys.first, v.values.first)
          end
        else
          p[k] = v
          p
        end
      end
      last = params[:new_field_value]
      params[:new_field].split(".").reverse.each { |k| last = { k => last }}

      add(params[:object_data], last.keys.first, last.values.first)
    end

    @object_data = params[:object_data] #ObjectData.new(params[:object_data])
    service = SalesforceEmailTemplateService.new params[:template], @object_data
    begin
      @result = service.render
    rescue Mustache::ContextMiss => e
      @error = e.message
    end
  end
end
