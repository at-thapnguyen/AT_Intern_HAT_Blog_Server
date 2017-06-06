class Api::V1::SearchsController < ApplicationController
  def show
    # search:
    # => bai viet theo title bai viet
    # => bai viet theo ten nguoi dung
    # => bai viet theo tag
    post_with_title = Article.search "%#{params[:key]}%"
    binding.pry
  end
end