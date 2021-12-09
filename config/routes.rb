Rails.application.routes.draw do
  scope :api do
    resources :flights, only: %i[index]
    resources :claims, only: %i[create index]
  end
end
