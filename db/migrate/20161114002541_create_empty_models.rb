class CreateEmptyModels < ActiveRecord::Migration[5.0]
  def change
    # create empty shells of slugs table to extend
    create_table :slugs do |t| 
      t.timestamps
    end

    # create emty shell of lookups table to extend
    create_table :lookups do |t| 
      t.timestamps
    end
  end
end
