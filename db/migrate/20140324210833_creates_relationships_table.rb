class CreatesRelationshipsTable < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :child_id
      t.integer :parent_id
      t.integer :count, default: 1
    end
  end
end
