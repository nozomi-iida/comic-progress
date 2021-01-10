class Comic < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :volume, presence: true
end
