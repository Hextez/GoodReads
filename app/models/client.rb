class Client < ApplicationRecord
  before_validation :downcase_email
  validates :username, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Invalid email format" } 

  private
  def downcase_email
    email.try(:downcase!)
  end
  
end
