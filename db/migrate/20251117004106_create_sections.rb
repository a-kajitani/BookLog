class CreateSections < ActiveRecord::Migration[8.1]
  def change
    create_table :sections do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :position

      t.timestamps
    end
    
    add_index :sections, [:book_id, :position]
    add_index :sections, [:book_id, :created_at]

  end
end
