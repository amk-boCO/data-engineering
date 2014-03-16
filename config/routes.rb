LivingSocial::Application.routes.draw do
  root 'home#index'

  post '/files/upload', to: 'files#upload'
end
