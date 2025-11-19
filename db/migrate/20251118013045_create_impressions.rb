class CreateImpressions < ActiveRecord::Migration[8.1]
  def change
    create_table :impressions do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
