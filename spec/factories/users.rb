FactoryBot.define do
  factory :user do
    name { "Mr. Test" }
    email { "test@test.com" }
    salt {nil}
    encrypted_password {nil}
    last_login_at { nil }
    locked_at { nil }
    last_login_ip { nil }
    failed_attempts { 0 }
  end
end
