class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  helpers = field_helpers +
              %w{date_select datetime_select time_select} +
              %w{collection_select select country_select time_zone_select} -
              %w{hidden_field label fields_for}

  def _options_index(field)
    ActionView::Helpers::FormBuilder.
      instance_method(field).
      parameters.
      index([:opt,:options])
  end

  def _options(field, *args)
    idx = _options_index(field.to_sym)
    if idx.nil?
      args.last.is_a?(Hash) ? args.pop : {}
    else
      args[idx - 1]
    end
  end

  helpers.each do |name|
    define_method(name) do |field, *args|
      options = _options(name, *args)
      if options[:label].nil?
        super(field, *args)
      else
        label = label(field,
                      options[:label] || field.to_s.titleize,
                      :class => (options[:label_class] || 'control-label'))
        @template.content_tag(:div, :class => 'control-group') do
          @template.concat(label)
          @template.concat(
            @template.content_tag(:div, :class => 'controls') do
              @template.concat(super(field, *args))
            end
          )
        end
      end
    end
  end

  define_method('check_box') do |field, *args|
    options = _options('check_box', *args)
    label_class = options[:label_class] || 'control-label'
    outer_label = label(field,
                        options[:short_label] || field.to_s.titleize,
                        :class => label_class)
    @template.content_tag(:div, :class => 'control-group clearfix') do
      @template.concat(outer_label)
      @template.concat(
        @template.content_tag(:div, :class => 'controls') do
          label(field, :class => 'checkbox') do
            super(field, *args) + options[:label]
          end
        end
      )
    end
  end

  def no_bs_fields_for(record_name, record_object = nil, options = {}, &block)
    options[:builder] = ActionView::Helpers::FormBuilder
    fields_for(record_name, record_object, options, &block)
  end

end
