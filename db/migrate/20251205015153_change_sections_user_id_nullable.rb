class ChangeSectionsUserIdNullable < ActiveRecord::Migration[8.1]
  def change 
    # user_id を NULL 許可に
    change_column_null :sections, :user_id, true

    # 既存 FK を張り替え（ない場合は rescue で無視されます）
    remove_foreign_key :sections, :users rescue nil
    add_foreign_key :sections, :users, column: :user_id, on_delete: :nullify
  end
end
