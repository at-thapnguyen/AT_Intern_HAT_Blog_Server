
require 'spec_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it(should validation_presense_of :fullname)
  end
end