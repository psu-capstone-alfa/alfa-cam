class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  helpers = field_helpers +
              %w{date_select datetime_select time_select} +
              %w{collection_select select country_select time_zone_select} -
              %w{hidden_field label fields_for}

  helpers.each do |name|
    define_method(name) do |field, *args|
      options_index = ActionView::Helpers::FormBuilder.instance_method(name.to_sym).parameters.index([:opt,:options])
      if options_index.nil?
        options = args.pop if args.last.is_a?(Hash)
      else
        options = args[options_index - 1]
      end
      options ||= {}
      label = label(field, options[:label], :class => options[:label_class])
      @template.content_tag(:div, :class => 'clearfix') do
        @template.concat(label)
        @template.concat(@template.content_tag(:div, :class => 'input') { @template.concat(super(field, *args)) })
      end
    end
  end

  define_method('submit') do |*args|
    if args.first && args.first.is_a?(Hash)
      value, options = nil, args.first
      options[:class] ||= 'btn primary'
    elsif args.second.is_a?(Hash)
      value, options = args.first, args.second
      options[:class] ||= 'btn'
    elsif args.length == 0
      value, options = nil, {class: 'btn primary'}
    else
      raise ArgumentError, "submit called with something other than options hash or value, options hash: #{args.inspect}"
    end
    @template.submit_tag(value, options)
  end

  define_method('cancel') do
    @template.button_tag('Cancel', {type: 'reset', class: 'btn'})
  end
end

ActionView::Base.default_form_builder = BootstrapFormBuilder
