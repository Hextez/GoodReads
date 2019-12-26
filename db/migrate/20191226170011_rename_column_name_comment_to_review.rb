class RenameColumnNameCommentToReview < ActiveRecord::Migration[6.0]
  def change
    rename_column :reviews, :comment, :review
  end
end
