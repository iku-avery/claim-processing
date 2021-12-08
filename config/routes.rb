Rails.application.routes.draw do
  scope :api do
    resources :flights
    resources :claims
  end
end
