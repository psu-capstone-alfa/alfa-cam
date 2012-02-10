module Offerings::ContentHelper
  def content_group_scope(group, &blk)
    id = dom_id(group)
    name = group.name.presence or 'New Group'
    yield group, id, name if blk
    [group, id, name]
  end

  def content_group_scopes(groups, &blk)
    groups.each_with_index do |group, i|
      css_class = (i == 0) ? 'active' : ''
      yield *content_group_scope(group), css_class
    end
  end
end
