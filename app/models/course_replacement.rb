#Details how courses replace one another
class CourseReplacement < ActiveRecord::Base

    belongs_to :replaces, class_name: 'Course', foreign_key: 'replace_id'
    belongs_to :replaced_with, class_name: 'Course', foreign_key: 'with_id'

    def to_s
      "#{replaced_with} replaces #{replaces}"
    end
end
