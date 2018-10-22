include ActionDispatch::TestProcess

FactoryBot.define do
  factory :pic do
    published { false }
    title { "MyString" }
    permalink { "MyString" }
    caption { "MyText" }
    location { "MyString" }
    lat { 1.5 }
    lng { 1.5 }

    before(:build) do |pic|
      pic.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'rails.jpg')), filename: 'rails.jpeg', content_type: 'image/jpeg')
    end
  end
end
