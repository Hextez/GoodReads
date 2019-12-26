class Book < ApplicationRecord
  belongs_to :author
  validates :name, uniqueness: {message: "already created"}
  validates_presence_of :name, :author
end
