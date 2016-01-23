Rails.application.routes.draw do
  get 'profile/index'

  get 'profile/podcasts'

  get 'profile/episodes'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'main/index'
  root 'main#index'
  get 'podcast/show/:id' => 'podcast#show'
  post 'podcast/create' => 'podcast#create'
  get 'podcast/create' => 'podcast#form'
  get 'podcast/:id/edit'=> 'podcast#edit'
  post 'podcast/:id/edit'=> 'podcast#update'
  get 'podcast/mylist'=> 'podcast#list'
  get 'podcast/:podcast_id/episode/:id/show' => 'episode#show'
  post 'podcast/:podcast_id/episode/create' => 'episode#create'
  get 'podcast/:podcast_id/episode/create' => 'episode#form'
  get 'podcast/:podcast_id/episode/:id/edit'=> 'episode#edit'
  post 'podcast/:podcast_id/episode/:id/edit'=> 'episode#update'
  get 'podcast/:podcast_id/episode/list'=> 'episode#list'
  get 'profile/:user_id' => 'profile#index'
  get 'category/:id' => 'category#show'
  get 'audio' => 'audio#get_info_from_file'
  post 'stat/:episode_id/:time_period' => 'stat#show'
  # get 'podcast/:id/add_episode' => 'episodes_manipulate#create_form'
  # post 'podcast/:id/add_episode' => 'episodes_manipulate#create'
  devise_for :users, controllers: { registrations: "users/registrations" }
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
