class User < ApplicationRecord
  # has_one :account
  has_many :articles
  has_many :attentions
  has_many :follow_user

  validates :username, presence: true
  validates :password, presence: true,length: { in: 6..15 }
  # validates :access, presence: true
  # validates :blocked, presence: true

  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "Email don't validated" }
end
