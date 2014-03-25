class Word < ActiveRecord::Base
  has_many :as_parent_relationships, class_name: 'Relationship', foreign_key: :parent_id
  has_many :as_child_relationships, class_name: 'Relationship', foreign_key: :child_id
  has_many :children, through: :as_parent_relationships
  has_many :parents, through: :as_child_relationships

  def next_word
    relationships = self.as_parent_relationships
    ids_probability_arr = []
    relationships.each do |r|
      r.count.times { ids_probability_arr << r.child_id }
    end
    Word.find(ids_probability_arr.sample)
  end
end
