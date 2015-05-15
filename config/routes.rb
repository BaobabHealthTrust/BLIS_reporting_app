Rails.application.routes.draw do

  ###### login ############################
  get 'login' => 'user/login'
  post 'authenticate' => 'user/authenticate'
  ###### login end ###########################

  ###### home ###########################
  #match "home/index" => "home#index", as: :home, via: [:get, :post]
  ###### home end ###########################

  ###### report ###########################
  #match "home/index" => "home#index", as: :home, via: [:get, :post]
  get 'reports' => 'report#index'
  ###### reports end ###########################



  get 'user/login'
  post 'user/authenticate'
  get 'config/index'
  
  get 'config/post_data'
  post 'config/post_data'
  get 'config/user_accounts'
  get 'config/test_types'
  get 'config/test_type_edit_popup'
  get 'config/test_type_disable'
  get 'report/tb_report'
  get 'report/report_range'
  get 'report/tb_report_mq'

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
  root 'home#index'
end
