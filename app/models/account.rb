class Account < ApplicationRecord
  has_many :ad_units, dependent: :destroy
  validates :login, presence: true
  validates :password, presence: true
end
