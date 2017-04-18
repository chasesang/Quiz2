class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates(:body,{ presence: true, length: { minimum: 2 } })
end
