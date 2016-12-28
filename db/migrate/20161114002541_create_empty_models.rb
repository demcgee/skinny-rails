class CreateEmptyModels < ActiveRecord::Migration[5.0]
  def change
    # create empty shells of slugs table to extend
    create_table :slugs do |t|
      t.text :given_url, :null => false
      t.text :slug, :null => false
    end

    # create empty shell of lookups table to extend
    create_table :lookups do |t|
      t.references :slug, index: true
      t.inet :ip_address
      t.text :referrer
      t.timestamps :created_at
    end
  end
end
