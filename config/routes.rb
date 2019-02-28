Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_scope :user do
    root to: "devise/sessions#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

  resources :dashboards, only: [:index] do
    collection do
      get :basic_info
    end
  end
  get 'tags/:tag', to: 'topics#index', as: :tag
  resources :topics do
    collection do
      get :your_topics
    end
    resources :posts do
      collection do
        post :leave_comment
      end
    end
  end
  resources :posts, only: [:index, :create]

end
