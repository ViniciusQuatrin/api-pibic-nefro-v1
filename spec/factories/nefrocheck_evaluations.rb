FactoryBot.define do
  factory :nefrocheck_evaluation do
    patient { nil }
    tfg { "9.99" }
    referral_needed { false }
    message { "MyString" }
    details { "MyText" }
  end
end
