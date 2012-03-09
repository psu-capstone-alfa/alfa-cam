class ChangeObjectiveDescriptionType < ActiveRecord::Migration
  def change
    change_table :objectives do |t|
      t.remove :description
      t.text :description
    end
  end
end
