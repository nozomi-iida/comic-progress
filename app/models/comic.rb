class Comic < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :volume, presence: true
end
