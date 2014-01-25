Quickbook42::Application.routes.draw do
  get "terms/legal"
  get "terms/features"

  resources :terms

  resources :coupens

  get "payments/index"
  get "payments/confirm"
  post "payments/complete"
  get "payments/checkout"
  post "payments/payment_authorize"
  post "payments/coupen_check"
  get "homes/show_means"
  get "homes/index2"
 
  
  
  resource "payments"
  devise_for :users, :controllers => {:registrations => "registrations",:sessions => "sessions",:passwords=>"passwords"}

  #devise_for :users
  resources :homes
  resources :databases
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
 root to: "homes#index"
   get "home/index"
    resource :feedback
  get "feedbacks/aboutus"
  get "feedbacks/contactus" 
  get "imports/download_quickbook"
  resources :erps
  post "erps/new"
  get "erps/new"
  get "erps/edit"
  post "erps/edit"
  get "erps/show"
  get "imports/download_quickbook"
  post "imports/download_quickbook"
  post "imports/import" 
  get  'imports/:id' => 'imports#index'
  post  'imports/:id' => 'imports#index'
  
  resources :imports

end
