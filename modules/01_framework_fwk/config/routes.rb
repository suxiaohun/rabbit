Rails.application.routes.draw do


  scope module: 'sys' do
    resources :users do
      collection do

      end
    end


    match 'login' => 'common#login', via: [:get, :post]
    match 'index' => 'common#index', :via => :get
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