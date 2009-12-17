ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if (html_tag=~/<label/).nil?
  %(<div class="validation-error">#{html_tag}<br>
    #{instance.object.class.human_attribute_name(instance.method_name.to_sym)} #{[instance.error_message].flatten.join(',')}</div>)
  else
    html_tag
  end
end
