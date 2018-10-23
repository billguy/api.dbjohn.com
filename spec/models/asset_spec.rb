require 'rails_helper'

RSpec.describe Asset, type: :model do
  it { is_expected.to callback(:destroy_attachment).before(:destroy) }
end
