class AddAuthorReferenceToBook < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :author, null: true, foreign_key: true
  end
end
