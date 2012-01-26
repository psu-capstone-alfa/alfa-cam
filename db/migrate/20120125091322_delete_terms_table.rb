class DeleteTermsTable < ActiveRecord::Migration
  def up
	  if table_exists? :terms
		  drop_table :terms
	  end
  end

  def down
	  if !table_exists? :terms
		  create_table :terms do |t|
			  t.string :title
			  t.timestamps
    	end
    end
	end		
end
