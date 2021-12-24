class CreateImpressions < ActiveRecord::Migration[6.1]
  def change
    create_table :impressions do |t|
      t.string :impressionable_type
      t.integer :impressionable_id
      t.string :ip_address
      t.timestamps
    end
  end
end
