class Driver < ApplicationRecord
  belongs_to :motorcycle
  belongs_to :person

  has_many :orders
end
