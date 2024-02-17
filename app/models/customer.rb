class Customer < ApplicationRecord
  belongs_to :person
  has_many :addresses, dependent: :destroy
  has_many :orders, through: :addresses
end
