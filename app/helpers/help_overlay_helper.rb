module HelpOverlayHelper

  def help_overlay_bubble(title, content, options = {})
    content_tag :div, class: 'help-bubble help-overlay' do
      content_tag(:a,
        title,
        :rel => 'popover',
        :style => options[:style],
        :class => "btn",
        'data-placement' => options[:position],
        'data-content' => content)
    end
  end

  def insert_help(key)
    return '' unless @help.has_key?(key)
    entry = {title: '', content: ''}.merge!(@help[key])
    help_overlay_bubble(
    entry.delete(:title),
    entry.delete(:content),
    entry)
  end

end
