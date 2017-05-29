class CommentSerializer < ActiveModel::Serializer
  attributes :id,:content,:user_id #, if: :count_comments
  belongs_to :user
  # def count_comments

  # end
end
