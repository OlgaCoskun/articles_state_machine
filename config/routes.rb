Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"

  resources :posts do
    resources :comments, only: [:create, :destroy] do
      member { get :like }
    end
    member { patch :send_to_moderator }
    member { patch :send_to_publish }

    collection do
      get 'moderator'
      get 'all'
    end
  end

  resources :users, only: [:new, :show, :edit, :update]

end
