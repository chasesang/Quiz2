class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates(:body,{ presence: true, length: { minimum: 2 } })

  def like_for(user)
  likes.find_by_user_id(user.id)
  end

end
