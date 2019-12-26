require 'rails_helper'

RSpec.describe Book, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  context "Model structure is correct" do
    it "has its required columns" do
      expect(subject).to have_db_column(:name)
    end

    it "has its associations" do
      expect(subject).to belong_to(:author)
    end
  end
  
  context "Model attributes" do
    let(:author) { Author.create(name: "Joao") }

    it "is valid with valid attributes" do
      book = Book.new(name: "BookOne", author: author)
      book.valid?
      expect(book.errors[:name]).not_to include("can't be blank")
    end
    it "is not valid without a author" do
      book = Book.new(name: "BookOne", author: nil)
      book.valid?
      expect(book.errors[:author]).to include("can't be blank")
    end
    it "is not valid without a author" do
      book = Book.new(name: nil, author: author)
      book.valid?
      expect(book.errors[:name]).to include("can't be blank")
    end
    it "is unique book name" do
      book = Book.new(name: "BookOne", author: author)
      expect(book).to be_valid
      book.save
      book2 = Book.new(name: "BookOne", author: author)
      book2.valid?
      expect(book2.errors[:name]).to include("already created")
    end
  end

end
