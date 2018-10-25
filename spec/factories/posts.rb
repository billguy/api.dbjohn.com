FactoryBot.define do
  factory :post do
    published { false }
    blog { true }
    title { "MyString" }
    permalink { "MyString" }
    content { "MyText" }
    javascript { "MyText" }

  end
end
