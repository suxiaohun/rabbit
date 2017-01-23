Rails.application.routes.draw do



  scope module: 'sys' do
    resources :users do
      collection do

      end
    end

  end
end