class Book < ApplicationRecord
  belongs_to :user, optional: true
  has_many :sections
  
  validates :title, presence: true
  validates :author, presence: true
end
