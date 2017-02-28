Rails.application.routes.draw do


  scope module: 'sys' do
    resources :users do
      collection do

      end
    end


    match 'login_in' => 'common#login_in', :via => :post
    match 'login_out' => 'common#login_out', :via => :get
    match 'login' => 'common#login', via: [:get,:post]
    match 'index' => 'common#index', :via => :get
    match 'login_records' => 'common#login_records', :via => :get
    match '/' => 'common#index', :via => :get

    #
    # resources :common do
    #
    #   collection do
    #     get 'login', as: 'login'
    #   end
    # end

  end
end