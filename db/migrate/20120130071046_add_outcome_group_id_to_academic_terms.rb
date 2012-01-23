class AddOutcomeGroupIdToAcademicTerms < ActiveRecord::Migration
  def change
    add_column :academic_terms, :outcome_group_id, :integer
  end
end
