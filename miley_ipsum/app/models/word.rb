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

  def end_occurance_probability
    (self.omega.to_f / self.count.to_f)
  end

  def is_last_word?
    probability = (self.end_occurance_probability * 100)
    (0..probability).include?((0..100).to_a.sample)
  end

  def self.random
    self.find(first_word_id)
  end

  def self.ipsum
    words = []
    words << self.random
    until (words.last.is_last_word?)
      words << words.last.next_word
    end
    words.map(&:word).join(' ')
  end

end
