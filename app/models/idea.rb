class Idea < ApplicationRecord
  belongs_to :category, optional: true
end
