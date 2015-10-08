Rails.application.routes.draw do

  def community_routes(prefix, defaults)
    get "#{prefix}/communities/:id/show", to: "communities#show", defaults: defaults
  end

  def collection_routes(prefix, defaults)
    get "#{prefix}/collections/:id/show", to: "collections#show", defaults: defaults
  end

  def item_routes(prefix, defaults)
    get "#{prefix}/items/:id/show", to: "items#show", defaults: defaults
  end

  def build_routes(layout)
    if (layout == 'application')
      prefix = "/" + layout
      defaults = { :layout => layout}
    else
      prefix = "/:layout"
      defaults = {}
    end
    community_routes(prefix, defaults)
    collection_routes(prefix, defaults)
    item_routes(prefix, defaults)
    get "#{prefix}/about", to: "application#about", defaults: defaults
    get "#{prefix}/search", to: "application#todo", defaults: defaults
  end

  root "communities#top", defaults: {layout: 'application'}

  build_routes('application')
  build_routes(':layout')

  get '/sitemap', to: "communities#top", defaults: { :layout => 'sitemap'}

  devise_for :users

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
