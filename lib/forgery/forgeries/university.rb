class Forgery::University < Forgery
  def self.course_subject
    dictionaries[:course_subjects].random.unextend
  end

  def self.course_title
    dictionaries[:course_titles].random.sub('#{IND}', Forgery::Name.industry).unextend
  end

  def self.content_group_name
    dictionaries[:content_group_names].random.unextend
  end

  def self.outcome
    dictionaries[:program_outcome].random.unextend
  end
end
