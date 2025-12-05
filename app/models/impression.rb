class Impression < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :section
  validates :body, presence: true, length: { maximum: 5000 }
end
