class CreateAcademicTerms < ActiveRecord::Migration
  def change
    create_table :academic_terms do |t|
      t.string :title

      t.timestamps
    end
  end
end
