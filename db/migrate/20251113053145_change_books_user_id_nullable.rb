class ChangeBooksUserIdNullable < ActiveRecord::Migration[8.1]
  
def change
    # user_id を NULL 許容に変更
    change_column_null :books, :user_id, true

    # 外部キー制約がある場合は、ON DELETE SET NULL を設定（対応DBのみ）
    # SQLite ではこの設定が無視されることもあるため、保険としてモデル側で nullify するのが安全です
    if foreign_key_exists?(:books, :users)
      remove_foreign_key :books, :users
      add_foreign_key :books, :users, column: :user_id, on_delete: :nullify
    end
  end
end
