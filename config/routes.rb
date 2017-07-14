Rails.application.routes.draw do
  get 'home/index'
  resources :members
	get 'download_csv', to: "members#download"
  root 'home#index'

  namespace 'stats' do
  	root 'stats#index'
  	get '/logarun' => 'stats#logarun'
  	get '/members' => 'stats#members'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
