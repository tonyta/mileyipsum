class Word < ActiveRecord::Base
  has_many :as_parent_relationships, class_name: 'Relationship', foreign_key: :parent_id
  has_many :as_child_relationships, class_name: 'Relationship', foreign_key: :child_id

  has_many :children, through: :as_parent_relationships
  has_many :parents, through: :as_child_relationships

  def next_word
    Word.find(all_children.sample)
  end

  def all_children
    relationships = self.as_parent_relationships #one call
    relationships.map{|r| [r.child_id] * r.count }.flatten #one call
  end

  def count #two database calls
    self.children.count + self.omega
  end

  def end_occurance_probability (index)#one database call + two database calls
    ((self.omega.to_f / self.count.to_f) + next_word_prob(index)) /2.0
  end

  def next_word_prob(index)
    is_there_next_word_prob(index)
  end

  def self.random # one database call
    self.find(first_word_id)
  end

  def self.ipsum
    words = []
    words << self.random #one call
    until (rand < words.last.end_occurance_probability(words.length)) && words.length >= 5 #three calls (per word)
      words << words.last.next_word #one call +
    end
    words.map(&:word).join(' ')
    rescue ActiveRecord::RecordNotFound
    words.map(&:word).join(' ')
  end

end
