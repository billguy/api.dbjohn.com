require 'rails_helper'

RSpec.describe Pic, type: :model do

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:caption) }
  it { is_expected.to callback(:update_location).before(:save).if(:coords_changed?) }
  it { is_expected.to callback(:destroy_photo).before(:destroy) }

  let(:pic){ FactoryBot.build(:pic) }
  describe '#correct_mime_type?' do
    it 'adds error if not an image' do
      expect(pic).to receive(:correct_mime_type?)
      pic.valid?
    end
  end

end
