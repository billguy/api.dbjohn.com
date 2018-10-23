include ActionDispatch::TestProcess

FactoryBot.define do
  factory :asset do

    before(:build) do |asset|
      asset.attachment.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'rails.jpg')), filename: 'rails.jpeg', content_type: 'image/jpeg')
    end
  end
end
