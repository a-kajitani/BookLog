class Book < ApplicationRecord
  belongs_to :user, optional: true
  has_many :sections, dependent: :destroy
  
  validates :title, presence: true
  validates :author, presence: true
end
