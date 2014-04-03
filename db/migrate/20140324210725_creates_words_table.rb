class CreatesWordsTable < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.integer :alpha, default: 0
      t.integer :omega, default: 0
    end
  end
end
