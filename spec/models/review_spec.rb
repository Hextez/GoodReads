require 'rails_helper'

RSpec.describe Review, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  context "Model structure is correct" do
    it "has its required columns" do
      expect(subject).to have_db_column(:review)
    end

    it "has its associations" do
      expect(subject).to belong_to(:client)
      expect(subject).to belong_to(:book)
    end
  end

  describe "Model attributes" do
    let(:book) { Fabricate(:book) }
    let(:client) { Fabricate(:client) }

    context "Valid attributes" do
      it "has valid attributes" do
        review = Review.new(book: book, client: client, review: "DADADDADD")
        expect(review).to be_valid
      end
    end

    context "Invalid attributes" do
      it "has null review" do
        review = Review.new(book: book, client: client, review: nil)
        expect(review).not_to be_valid
      end

      it "has null client" do
        review = Review.new(book: book, client: nil, review: "SA")
        expect(review).not_to be_valid
      end

      it "has null book" do
        review = Review.new(book: nil, client: client, review: "SADD")
        expect(review).not_to be_valid
      end
    end
  end
end
