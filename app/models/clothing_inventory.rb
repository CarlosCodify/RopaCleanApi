class ClothingInventory < ApplicationRecord
  belongs_to :clothing_type
  belongs_to :order
end
