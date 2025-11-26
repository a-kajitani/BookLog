class AddNotNullConstraintsToUsers < ActiveRecord::Migration[8.1]
  def change  
    change_column_null :users, :email, false
    change_column_null :users, :encrypted_password, false
    change_column_null :users, :name, false
  end
end
