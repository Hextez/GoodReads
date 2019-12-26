require 'rails_helper'

RSpec.describe Client, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  context "Model structure is correct" do
    it "has its required columns" do
      expect(subject).to have_db_column(:username)
      expect(subject).to have_db_column(:email)
    end
  end

  context "Model valid attributes" do
    it "has valid attributes" do
      client = Client.new(username: "Joao", email: "asd@sadas.com")
      expect(client).to be_valid
    end

    it "has no name attribute" do
      client = Client.new(username: nil, email: "asd@sadas.com")
      expect(client).not_to be_valid
    end
    it "has no email attribute" do
      client = Client.new(username: "JOAO", email: nil)
      expect(client).not_to be_valid
    end
    
    it "has valid no attributes" do
      client = Client.new(username: nil, email: nil)
      expect(client).not_to be_valid
    end

    it "has invalid email" do
      client = Client.new(username: "JOAO", email: "asdsadas.com")
      client.valid?
      expect(client.errors[:email]).to include("Invalid email format")
    end
  end
end
