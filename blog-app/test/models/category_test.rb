# == Schema Information
#
# Table name: categories
#
#  id      :integer          not null, primary key
#  name    :string(255)
#  deleted :boolean          default("0")
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
