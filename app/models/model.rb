class Model < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :motorcycles, dependent: :destroy
  belongs_to :brand
end
