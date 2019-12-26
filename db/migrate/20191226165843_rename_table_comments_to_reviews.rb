class RenameTableCommentsToReviews < ActiveRecord::Migration[6.0]
  def change
    rename_table :comments, :reviews
  end
end
