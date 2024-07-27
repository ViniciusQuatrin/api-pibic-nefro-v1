Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "auth"

  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "pages#home"

  namespace :api do
    namespace :v1 do
      resources :patients
      resources :doctors
      resources :appointments
      resources :results
      resources :exams
      resources :questions
      resources :patient_questions
    end
  end
end
