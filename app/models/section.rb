class Section < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :content, presence: true, length: { maximum: 20_000 }

  
  # 並び順のためのスコープ
  scope :ordered, -> { order(position: :asc, created_at: :asc) }
end
