class Review < ApplicationRecord
  belongs_to :client
  belongs_to :book
  validates :review, presence: true
end
