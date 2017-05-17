class User < ActiveRecord::Base

  attr_accessor :token
  before_create :confirmation_token

  has_many :articles
  has_many :attentions
  has_many :follow_user

  validates :username, presence: true
  validates :password, presence: true, length: { in: 6..15 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: "Email don't validated" }
  has_secure_password

  # enum email: [:unpublished, :published]

  # def self.published_in_the_past
  #   we expect this method to fail first
  #   where(nil)
  # end

  acts_as_paranoid column: :blocked, sentinel_value: false

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end


