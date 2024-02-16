class Motorcycle < ApplicationRecord
  belongs_to :model
  has_one :driver

  scope :without_driver, -> { includes(:driver).where(drivers: { id: nil }) }
end
