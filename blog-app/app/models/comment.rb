class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :content, presence: true
  validates :isChecked, presence: true
  validate_inclusion_of :isChecked, :in => [true, false]
  validates_associated :article, :user

end