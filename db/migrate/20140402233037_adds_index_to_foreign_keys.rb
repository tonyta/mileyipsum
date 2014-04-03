class AddsIndexToForeignKeys < ActiveRecord::Migration
  def change
    add_index :relationships, :child_id
    add_index :relationships, :parent_id
  end
end
