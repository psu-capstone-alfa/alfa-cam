module ApplicationHelper
  def bs_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

  def bs_fields_for(record_name, record_object = nil, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    fields_for(record_name, record_object, options, &block)
  end
end
