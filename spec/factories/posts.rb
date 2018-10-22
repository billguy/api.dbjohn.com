FactoryBot.define do
  factory :post do
    published { false }
    title { "MyString" }
    permalink { "MyString" }
    content { "MyText" }
    javascript { "MyText" }

  end
end
