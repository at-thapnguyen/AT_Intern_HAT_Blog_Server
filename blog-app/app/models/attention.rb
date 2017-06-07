# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  isLiked    :boolean          default("0")
#  isFollowed :boolean          default("0")
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

#  isLiked    :boolean          default("0")
#  isFollowed :boolean          default("0")
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

class Attention < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :article_id, presence: true
  validates :user_id, presence: true
  has_many :notifications, as: :notificationable, dependent: :destroy

  scope :follow_action, ->(slug, current_user){
    article = Article.find_by_slug(slug)
    attention = self.find_by article_id: article.id, user_id: current_user.id

    if attention.present?
      # Neu co record attention
      if attention.isLiked == false
        # Neu co attention nhung attention voi: isLike=false va isFollow=true.
        # thi khi cap nhat isFollow = false thi:
        # => attention nay co isLiked = false va isFollowed = false
        # => truong hop nay ta xoa di record nay.
        if attention.isFollowed == true
          attention.destroy
        else
        # Neu co attention nhung attention voi: isLike=false va isFollow=false.
        # thi khi cap nhat isFollow = false thi:
        # => attention nay co isLiked = false va isFollowed = true
        # => truong hop nay ta chi cap nhat attention va add them thong bao
          attention.update_columns isFollowed: true
          message = Const::message article, current_user, "follow"
          attention.notifications.create user_id: article.attributes["user_id"], message: message, image: article.title_image if current_user.id != article.attributes["user_id"]
        end
      else
        # Neu co attention nhung attention voi: isLike=true
        # Khi ta cap nhat trang thai isFollowed ta chi can cap nhat roi them hoac xoa thong bao
        # => khong can xoa attention
        if attention.isFollowed == true
          attention.update_columns isFollowed: false
          # Xoa thong bao (notification).
          # Vi notification_type va notification_id cua 2 hanh dong like va follow la giong nhau
          # => Nen ta chi xoa 1 trong 2 record
          # => Ta chi con cach dua vao message de chon cai can xoa
          notifications = attention.notifications.where notificationable_type: attention.class.name, notificationable_id: attention.id
          if notifications.size == 2
            if notifications.first.message.include? "followed"
              notifications.first.destroy
            else
              notifications.last.destroy
            end
          else
            notifications.first.destroy
          end
        else
          # Cap nhat trang thai cua isFollowed = false => true
          # => Attention sau khi cap nhat co isFollowed = true va isLike = true
          attention.update_columns isFollowed: true
          message = Const::message article, current_user, "follow"
          attention.notifications.create user_id: article.attributes["user_id"], message: message, image: article.title_image if current_user.id != article.attributes["user_id"]
        end
      end
    else #end of if attention.present?
      #Neu chua co record trong bang attention thi tao moi
      attention = Attention.create article_id: article.id, user_id: current_user.id, isFollowed: 1
      message = Const::message article, current_user, "follow"
      attention.notifications.create user_id: article.attributes["user_id"], message: message, image: article.title_image if current_user.id != article.attributes["user_id"]
    end
  }


  scope :like_action, ->(slug, current_user){
    article = Article.find_by_slug(slug)
    attention = self.find_by article_id: article.id, user_id: current_user.id
    # Neu co record attention
    if attention.present?
      # Neu co attention nhung attention voi: isFollowed=false va isLiked=true.
      # thi khi cap nhat isLiked = false thi:
      # => attention nay co isLiked = false va isFollowed = false
      # => truong hop nay ta xoa di record nay.
      # => Cap nhat count_likes (-1)
      if attention.isFollowed == false
        if attention.isLiked == true
          article.update_columns count_like: article.count_like - 1
          attention.destroy
        else
          article.update_columns count_like: article.count_like + 1
          attention.update_columns isLiked: true
          message = Const::message article, current_user, "like"
          attention.notifications.create user_id: article.attributes["user_id"], message: message, image: article.title_image if current_user.id != article.attributes["user_id"]
        end
      else
        if attention.isLiked == true
          article.update_columns count_like: article.count_like - 1
          attention.update_columns isLiked: false
          notifications = attention.notifications.where notificationable_type: attention.class.name, notificationable_id: attention.id
          if notifications.size == 2
            if notifications.first.message.include? "liked"
              notifications.first.destroy
            else
              notifications.last.destroy
            end
          else
            notifications.first.destroy
          end
        else
          attention.update_columns isLiked: true
          article.update_columns count_like: article.count_like + 1
          message = Const::message article, current_user, "like"
          attention.notifications.create user_id: article.attributes["user_id"], message: message, image: article.title_image if current_user.id != article.attributes["user_id"]
        end
      end
    else #end of if attention.present?
      attention = Attention.create article_id: article.id, user_id: current_user.id, isLiked: true
      article.update_columns count_like: article.count_like + 1
      message = Const::message article, current_user, "like"
      # message = "#{ current_user.username } liked your post #{ attention.article.content[0..10] }"
      attention.notifications.create user_id: article.attributes["user_id"], message: message, image: article.title_image if current_user.id != article.attributes["user_id"]
    end
    article.count_like
  }

end
