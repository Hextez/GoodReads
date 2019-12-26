class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    books = Book.all
    json_response(books)
  end

  def create
    book = Book.create(book_param)
    if book.save
      json_response(book, :created)
    else
      json_response({message: book.errors}, :bad_request)
    end
  end

  def show
    json_response(@book)
  end

  def update
    if @book.update(book_param)
      json_response(@book)
    else
      json_response({message: @book.errors }, :bad_request)
    end
  end

  def destroy
    if @book.destroy
      json_response(@destroy)
    else
      json_response({message: @book.errors})
    end
  end

  private
  def book_param
    params.require(:book).permit(:name, :description, :author_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
