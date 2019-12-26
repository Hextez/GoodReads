require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "GET books index" do
    context "No data inside" do
      let(:result) { JSON.parse(response.body) }

      it "returns a empty array" do
        get :index
        expect(response.status).to eq(200)
        expect(result).to eq([])
      end
    end

    context "With data" do
      let(:result) { JSON.parse(response.body) }
      before { Fabricate.times(10, :book)}

      it "returns data" do
        get :index
        expect(response.status).to eq(200)
        expect(result.length).to eq(10)
      end
    end
  end

  describe "POST Book create" do
    context "create valid attribute book" do
      let(:result) { JSON.parse(response.body) }
      let(:author) { Fabricate(:author) }
      let(:attributes) { { book: { name: "BookTwo", author_id: author.id } } }
      before { post :create, params: attributes }

      it "has valid attributes" do
        expect(result["name"]).to eq("BookTwo") 
      end

      it "has valid status code" do
        expect(response.status).to eq(201)
      end
    end

    context "create book with invalid attributes" do
      let(:result) { JSON.parse(response.body) }
      let(:author) { Fabricate(:author) }
      let(:book) { Fabricate(:book) } 
      let(:attributes) { { book: { name: "BookThree", author_id: author.id } } }

      it "has null name attribute" do
        attributes[:book][:name] = nil
        post :create, params: attributes
        expect(response.status).not_to eq(201)
        expect(result["message"]["name"]).to include("can't be blank")
      end

      it "has null author attribute" do
        attributes[:book][:author_id] = nil
        post :create, params: attributes 
        expect(response.status).not_to eq(201)
        expect(result["message"]["author"]).to include("can't be blank")
      end

      it "has null author attribute" do
        post :create, params: {} 
        expect(response.status).not_to eq(201)
        expect(result["message"]).to include("param is missing or the value is empty")
      end

      it "has null attributes" do
        attributes[:book][:name] = nil
        attributes[:book][:author_id] = nil
        post :create, params: attributes 
        expect(response.status).not_to eq(201)
        expect(result["message"]["name"]).to include("can't be blank")
      end

      it "has null attributes" do
        attributes[:book] = nil
        post :create, params: attributes 
        expect(response.status).not_to eq(201)
        expect(result["message"]).to include("param is missing or the value is empty")
      end

      it "has invalid author attribute" do
        attributes[:book][:author_id] = 5000
        post :create, params: attributes 
        expect(response.status).not_to eq(201)
        expect(result["message"]["author"]).to include("must exist")
      end

      it "has same name of already created book" do
        attributes[:book][:name] = book.name
        post :create, params: attributes 
        expect(response.status).not_to eq(201)
        expect(result["message"]["name"]).to include("already created")
      end
    end
  end

  describe "GET Book" do
    before { Fabricate.times(10, :book)}
    let(:book_id) { Book.all.first.id}
    before { get :show, params: { id: book_id } }
    let(:result) { JSON.parse(response.body) }


    context "Book exists" do
      it "has valid status code" do
        expect(response.status).to eq(200)
      end
      
      it "has valid book object returned" do
        expect(result["id"]).to eq(book_id)
      end
    end

    context "Book don't exist" do
      let(:book_id) { 5000 }

      it "has invalid status code" do 
        expect(response.status).not_to eq(200)
      end

      it "has error message" do
        expect(result["message"]).to include("Couldn't find Book with 'id'=#{book_id}")
      end
    end
  end

  describe "PUT Update" do
    context "Update existing book" do
      let(:result) { JSON.parse(response.body) }
      let(:author) { Fabricate(:author) }
      let(:book) { Fabricate(:book) }
      let(:attributes) { { name: "BookFour", author_id: author.id, description: "SOME THING" } } 
      

      it "has valid attributes" do
        put :update, params: {id: book.id, book: attributes }
        expect(response.status).to eq(200)
        expect(result["name"]).to eq("BookFour")
      end

      it "has same name attribute" do
        attributes[:name] = book.name
        put :update, params: { id: book.id, book: attributes }
        expect(response.status).to eq(200)
      end

      it "has invalid attribute name" do
        attributes[:name] = nil
        put :update, params: { id: book.id, book: attributes }
        expect(response.status).not_to eq(200)
      end

      it "has invalid attribute author" do
        attributes[:author_id] = nil
        put :update, params: { id: book.id, book: attributes }
        expect(response.status).not_to eq(200)
      end

      it "has no attribute" do
        put :update, params: { id: book.id, book: {} }
        expect(response.status).not_to eq(200)
      end
    end

    context "Update not existing book" do
      let(:author) { Fabricate(:author) }
      before { put :update, params: { id: 10000, book: { name: "BookFour", author_id: author.id, description: "SOME THING" } } }

      it "book don't exist" do
        expect(response.status).not_to eq(200)
      end
    end
  end

  describe "Delete Book" do
    let(:book_id) { Fabricate(:book).id }
    before { delete :destroy, params: { id: book_id } }

    context "Exists book" do
      it "valid status code" do
        expect(response.status).to eq(200)
      end
    end

    context "Don't exist book" do
      let(:book_id) { 10500 }
      it "has invalid code" do
        expect(response.status).not_to eq(200)
      end
    end
  end
end
