class AddDateToAcademicTerm < ActiveRecord::Migration
  def change
    add_column :academic_terms, :start_date, :date
    add_column :academic_terms, :end_date, :date
  end
end
