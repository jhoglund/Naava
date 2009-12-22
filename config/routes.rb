ActionController::Routing::Routes.draw do |map|

  map.resource :user_session
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.resources :bookings, :member => { :book => [ :get, :post ], :paypal_ipn => [ :get, :post ], :paypal_success => [ :get, :post ], :paypal_cancel => [ :get, :post ] }, :except => [ :index ]

  map.resources :sessions, :member => { :book => [ :get, :post ] } do |session|
    session.bookings 'bookings/:id', :controller => 'courses', :action => 'bookings'
  end

  map.resources :courses, :member => { :book => [ :get, :post ] }, :has_one => :instructor
  map.resources :instructors
  map.resources :gift_certificates, :new => { :new => :post }, :member => { :print => [ :any ] }, :collection => { :paypal_ipn => [ :get, :post ], :paypal_success => [ :get, :post ], :paypal_cancel => [ :get, :post ] } do |coupon_types|
    coupon_types.resources :sessions, :member => { :book => [ :get, :post ] } do |session|
      session.bookings 'bookings/:id', :controller => 'courses', :action => 'bookings'
    end
    coupon_types.resources :courses, :member => { :book => [ :get, :post ] }, :has_one => :instructor
  end
  map.resources :coupons, :new => { :new => :post }, :collection => { :print => [ :any ], :paypal_ipn => [ :get, :post ], :paypal_success => [ :get, :post ], :paypal_cancel => [ :get, :post ] } do |coupon_types|
    coupon_types.resources :sessions, :member => { :book => [ :get, :post ] } do |session|
      session.bookings 'bookings/:id', :controller => 'courses', :action => 'bookings'
    end
    coupon_types.resources :courses, :member => { :book => [ :get, :post ] }, :has_one => :instructor
  end
  map.resources :payments, :only => [ :show, :update ] #, :show => { :show => [:get, :post] }
  
  
  map.namespace(:admin) do |admin|
  	admin.resources :sessions, :has_many => [ :bookings ]
	  admin.resources :bookings
	  admin.resources :instructors
    admin.resources :users
	  admin.resources :coupons
    admin.resources :coupon_types
    admin.resources :payments
    admin.resources :courses, :member => { :clone => :get } do |course| 
  	  course.resources :sessions, :has_many => [ :bookings ]
  	  course.resources :bookings
      course.resources :participants
    end
  end
  
  map.about_ashtanga_yoga '/about_ashtanga_yoga', :controller => 'welcome', :action => 'about_ashtanga_yoga'
  map.good_to_know '/good_to_know', :controller => 'welcome', :action => 'good_to_know'
  map.our_studio '/our_studio', :controller => 'welcome', :action => 'our_studio'
  map.location '/location', :controller => 'welcome', :action => 'location'
  map.root :controller => "welcome"
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
ActionController::Routing::Translator.translate_from_file('config/locales','i18n-routes.yml')
