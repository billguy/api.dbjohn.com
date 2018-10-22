require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to callback(:encrypt_password).before(:save) }
  it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(20) }

end
