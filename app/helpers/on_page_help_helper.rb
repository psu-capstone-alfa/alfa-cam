module OnPageHelpHelper
  def help_tooltip(content, options = {} )
    options[:position] ||= 'bottom'

    content_tag :a,
                 :rel => 'tooltip',
                 'data-placement' => options[:position],
                 'title' => content do
      content_tag :i, '', :class => "icon-black  icon-question-sign"
    end
  end

end