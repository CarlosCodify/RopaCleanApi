class Model < ApplicationRecord
  has_many :motorcycles, dependent: :destroy
  belongs_to :brand
end
