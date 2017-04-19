class User < ApplicationRecord
  has_secure_password
  has_many :ideas, dependent: :nullify
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea

  validates(:first_name, { presence: true })
  validates(:last_name, { presence: true })

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                        uniqueness: true,
                        case_sensitive: false,
                        format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end                      
end
