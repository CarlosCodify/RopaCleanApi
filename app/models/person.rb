class Person < ApplicationRecord
  belongs_to :user
  has_one :customer, dependent: :destroy
  has_one :driver, dependent: :destroy
end
