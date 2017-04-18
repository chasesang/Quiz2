Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ideas do
    resources :reviews, only: [:create, :destroy, :update]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only:[:new, :create] do
     delete :destroy, on: :collection
   end

  root 'ideas#index'

end
