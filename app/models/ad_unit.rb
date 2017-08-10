class AdUnit < ApplicationRecord
   belongs_to :account
   validates :url, presence: true
end
	