require 'rails_helper'

RSpec.describe Author, type: :model do
  context "Model structure is correct" do
    it "has its required columns" do
      expect(subject).to have_db_column(:name)
    end

    it "has its associations" do
      expect(subject).to have_many(:books)
    end
  end
  
  context "Model attributes" do
    it "is valid with valid attributes" do
      author = Author.new(name: "Joao")
      author.valid?
      expect(author.errors[:name]).not_to include("can't be blank")
    end
    it "is not valid without a name" do
      author = Author.new
      author.valid?
      expect(author.errors[:name]).to include("can't be blank")
    end
  end
end
