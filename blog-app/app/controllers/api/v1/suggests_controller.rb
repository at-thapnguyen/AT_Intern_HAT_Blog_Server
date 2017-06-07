class Api::V1::SuggestsController < BaseController
  def create
    tags = Category.find(params[:article][:category_id]) if params[:article][:category_id].present?
    suggest = Array.new
    #XU ly chuoi params[:article][:content]
    tags.each do |tag|

    end
  end
end
