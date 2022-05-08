Rails.application.routes.draw do
  get 'messages/index'
  get '/health_check', to: proc { [200, {}, ['success']] }
  root 'messages#index'
end
