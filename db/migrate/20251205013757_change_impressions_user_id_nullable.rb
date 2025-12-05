class ChangeImpressionsUserIdNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :impressions, :user_id, true 
    remove_foreign_key :impressions, :users rescue nil
    add_foreign_key :impressions, :users, column: :user_id, on_delete: :nullify
  end
end
