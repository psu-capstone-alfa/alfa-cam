# Provides Bootstrap style control groups, labels, tooltips, and error handling
#
class FancyFormBuilder < ActionView::Helpers::FormBuilder
  def control_group(attribute, options={}, &blk)
    label = options.delete :label
    label &&= self.label(attribute, label, options.slice(:tooltip, :position))
    div_class = 'control-group'
    div_class << ' error' unless @object.errors[attribute].empty?

    @template.content_tag(:div, class: div_class) do
      @template.concat label
      @template.concat(
        @template.content_tag(:div, :class => 'controls') do
          yield
        end
      )
    end
  end

  def label(attribute, text=nil, options={})
    tooltip = options.delete(:tooltip)
    tooltip &&= help_tooltip(tooltip)
    options[:class] = 'control-label'
    super(attribute, options) do
      @template.concat text
      @template.concat ' '
      @template.concat tooltip
    end
  end

  def help_tooltip(content, options = {} )
    options[:position] ||= 'left'
    @template.content_tag(:a,
        rel: 'tooltip',
        'data-placement' => options[:position],
        title: content) do
      @template.content_tag(:i, '', class: 'icon-question-sign')
    end
  end

  error_aware_helpers = [:text_field, :text_area]

  error_aware_helpers.each do |helper|
    define_method(helper) do |attribute, *args|
      errors = @object.errors[attribute]
      unless errors.empty?
        options = args.extract_options!
        options[:rel] = 'tooltip'
        options[:title] = errors.join.humanize
        options['data-trigger'] = 'focus'
        args.unshift options
        super attribute, *args
      else
        super attribute, *args
      end
    end
  end

end
