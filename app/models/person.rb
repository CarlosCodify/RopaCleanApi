class Person < ApplicationRecord
  belongs_to :user
  has_one :customer, dependent: :destroy
end
