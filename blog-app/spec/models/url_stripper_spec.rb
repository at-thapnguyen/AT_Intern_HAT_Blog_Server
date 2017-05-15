require 'rails_helper'

RSpec.describe UrlStripper, type: :model do
  it 'should have good stripper' do
    input = '<a href="http://kipalog.com/">DIE HARD</a>'
    expected_output = 'DIE HARD'
    output = UrlStripper.strip(input)
    expect(output).to eq(expected_output)
  end
end
