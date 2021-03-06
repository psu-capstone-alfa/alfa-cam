CourseAssessmentManager::Application.routes.draw do
  resources :content_group_names


  post "export/search"
  get "export/search"

  resources :academic_terms do
    member { get 'bulk_courses' }

    resources :courses do
      collection { get :bulk_edit }
    end

    namespace :offerings do
      resource :bulk, only: [:edit, :update, :create]
    end

    resources :offerings, only: [:new, :create, :index]
  end

  scope controller: :dashboard, path: 'home', as: 'home' do
    get '', action: :home
    get :reviewer
    get :instructor
    get :staff
    get :staff2
    get :admin
  end

  resources :outcome_groups do
    resources :outcomes, shallow: true
  end

  scope controller: :notification, path: 'notification', as: 'notification' do
    get '', action: :home
    get :remind
    get :start_term
  end

  resources :offerings, except: [:new,:create,:index] do
    collection do
      match '/' => 'offerings#search', via: [:get, :post]
      post :search; get :search;
      get :export
      get :facets
      get :search_explanation
    end
    member do
      get :export, action: :export_member, as: "export"
    end
    scope :module => :offerings do # Sub controllers under Offering::
      resource :review, only: [:edit, :show], controller: :review do
        post :edit
        post :show
      end

      resource :importing, only: [:edit, :show], controller: :importing do
        post :edit
        post :import
      end

      resource :details, only: [:edit, :show, :update, :destroy]

      resource :objectives, only: [:edit, :show, :update, :destroy] do
        get :summary, as: 'summarize'
      end

      resource :content, only: [:edit, :show, :update, :destroy] do
        get :summary, as: 'summarize'
      end

      resource :assessments, only: [:edit, :show, :update, :destroy] do
        get :summary, as: 'summarize'
      end
    end
  end

  resource :user_session,
    path: 'session',
    only: [:create, :destroy]
  match 'login' => 'user_sessions#new', as: 'login'
  match 'logout' => 'user_sessions#destroy', as: 'logout'
  match 'unauthorized' => "misc#un_auth", as: 'unauthorized'

  resources :users
  match 'profile' => 'users#profile', as: 'profile'

  root to: 'dashboard#home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
