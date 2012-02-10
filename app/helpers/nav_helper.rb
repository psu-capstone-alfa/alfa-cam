module NavHelper

  def active_if(this, is)
    ''
    'active' if this.is_a?(Hash) and this.include?(is)
    'active' if this == is
  end

end
