class AddNumCopiesToList < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :num_copies, :integer, default: 0
  end
end
