Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "aircrafts#index"

  get "/aircrafts", to: "aircrafts#index"
  get "/aircrafts/new", to: "aircrafts#new"
  get "/aircrafts/show", to: "aircrafts#show"

  post "/aircrafts", to: "aircrafts#enqueue"
  delete "/aircrafts/dequeue", to: "aircrafts#dequeue"
end
