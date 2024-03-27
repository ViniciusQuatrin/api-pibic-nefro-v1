FactoryBot.define do
  factory :patient do
    user { nil }
    name { "MyString" }
    sex { 1 }
    creatinine { "9.99" }
    race { 1 }
  end
end
