class Relationship < ActiveRecord::Base
  belongs_to :parent, class_name: 'Word', foreign_key: :parent_id
  belongs_to :child, class_name: 'Word', foreign_key: :child_id
end
