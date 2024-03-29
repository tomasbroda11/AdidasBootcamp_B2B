Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users, controllers: { registrations: 'registrations' }


  resources :products, only: :index, path:"/"
  

  get '/profile', to: 'profiles#show', as: 'user_profile'

  
  resources :budgets, only: [:index, :destroy, :edit, :update], path: "/budgets" do
    resources :budget_items, only: [:destroy], shallow: true
  end

  resources :products do
    post 'add_to_budget', on: :member
  end
  

end
