# Whoo, monkey patchin' !

class Integer
  def repetitions(item=nil, &block)
    range = (1..self).to_a
    if block_given?
      warn "warning: ignoring item argument" unless item.nil?
      range.map! &block
    else
      range.map! { item }
    end
  end
end

