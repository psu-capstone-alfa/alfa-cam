module ApplicationHelper
  # twitter-bootstrap form builder
  def bs_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

  # twitter-bootstrap fields
  def bs_fields_for(record_name, record_object = nil, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    fields_for(record_name, record_object, options, &block)
  end

  # default form builder
  def no_bs_form_for(object, options = {}, &block)
    options[:builder] = ActionView::Helpers::FormBuilder
    form_for(object, options, &block)
  end

  # default fields
  def no_bs_fields_for(record_name, record_object = nil, options = {}, &block)
    options[:builder] = ActionView::Helpers::FormBuilder
    fields_for(record_name, record_object, options, &block)
  end
end
