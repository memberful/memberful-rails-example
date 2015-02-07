FactoryGirl.define do
  factory :administrator do
    email { |n| "admin_#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

end
