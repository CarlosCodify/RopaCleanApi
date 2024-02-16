class Order < ApplicationRecord
  belongs_to :pickup_address, class_name: 'Address', optional: true
  belongs_to :delivery_address, class_name: 'Address', optional: true
  belongs_to :driver
  belongs_to :order_status
  belongs_to :payment_status
  has_many :payments, dependent: :destroy
  has_many :clothing_inventories, dependent: :destroy
  has_one :customer, through: :pickup_address
  has_one :person, through: :customer
end
