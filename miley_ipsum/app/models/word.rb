class Word < ActiveRecord::Base
  has_many :as_parent_relationships, class_name: 'Relationship', foreign_key: :parent_id
  has_many :as_child_relationships, class_name: 'Relationship', foreign_key: :child_id

  has_many :children, through: :as_parent_relationships
  has_many :parents, through: :as_child_relationships

  def next_word
    Word.find(all_children.sample)
  end

  def all_children
    relationships = self.as_parent_relationships
    relationships.map{|r| [r.child_id] * r.count }.flatten
  end

  def count
    self.children.count + self.omega
  end

  def self.random
    self.find(first_word_id)
  end

  def self.ipsum(num_words)
    words = []
    words << self.random
    (num_words - 1).times do
      words << words.last.next_word
    end
    words.map(&:word).join(' ')
  rescue ActiveRecord::RecordNotFound
    words.map(&:word).join(' ')
  end

end
