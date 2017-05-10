class Article < ApplicationRecord
  has_many :comments
  has_many :attentions
  belongs_to :category
  belongs_to :user

  validates :title_image, presence: true
  validates :content, presence: true
  validates :deleted, presence:true
  validates_inclusion_of :deleted, :in => [true, false]

  validates_associated :comments, :attentions, :category, :user

end
