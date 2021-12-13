Rails.application.routes.draw do
  scope :api do
    resources :claims, only: %i[create index show]
    get 'flights(/:id)', to: 'flights#export', defaults: { format: :csv }
  end
end
