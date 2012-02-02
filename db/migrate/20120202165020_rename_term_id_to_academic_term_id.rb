class RenameTermIdToAcademicTermId < ActiveRecord::Migration
  def change 
    rename_column :offerings, :term_id, :academic_term_id    
  end
end
