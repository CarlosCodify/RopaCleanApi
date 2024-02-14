class Order < ApplicationRecord
  belongs_to :pickup_address
  belongs_to :delivery_address
  belongs_to :driver
  belongs_to :order_status
  belongs_to :payment_status
  has_many :payments, dependent: :destroy
  has_many :clothing_inventories, dependent: :destroy
end
