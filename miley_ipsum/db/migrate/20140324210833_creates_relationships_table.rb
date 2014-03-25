class CreatesRelationshipsTable < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :child_id
      t.integer :parent_id
      t.integer :count
    end
  end
end
