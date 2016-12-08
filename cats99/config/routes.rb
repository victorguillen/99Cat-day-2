# Prefix Verb  URI Pattern            Controller#Action
# user POST  /user(.:format)              users#create
# new_user GET   /user/new(.:format)         users#new
# GET   /user(.:format)                            users#show

NinetyNineCatsDay1::Application.routes.draw do

  resource :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:show, :new, :create]

  resources :cats, except: :destroy

  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end

  root to: redirect("/cats")
end
