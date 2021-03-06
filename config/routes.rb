Rails.application.routes.draw do

  root "communities#top", :layout => "default"

  scope "/:layout" do

    resources :communities, :only =>[:show, :new, :edit, :destroy]
    resources :collections, :only =>[:show]
    resources :items, only: [:show]
    resources :bitstreams, only: [:show]

    resources :config_types do
      resources :config_values, :only =>[:index, :new, :create, :update]
    end
    resources :config_values, :except => [:new, :create, :update]

    get 'about' => "application#about"

    get '/handle/:part1/:part2', to:  "application#handle", as: 'handle'

    ['search'].each do |action|
      get action => "application#todo"
    end

    get '' => "communities#top"

    devise_for :users

  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
