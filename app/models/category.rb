class Category < ApplicationRecord
  has_many :ideas, dependent: :destroy
  validates :name, uniqueness: true
end
