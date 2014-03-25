class Word < ActiveRecord::Base
  has_many :as_parent_relationships, class_name: 'Relationship', foreign_key: :parent_id
  has_many :as_child_relationships, class_name: 'Relationship', foreign_key: :child_id
  has_many :children, through: :as_parent_relationships
  has_many :parents, through: :as_child_relationships
end
