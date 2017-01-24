Rails.application.routes.draw do
  get 'main/index'

  get 'main/convert/(:id)', to: 'main#convert', as: :convert

  match ':controller(/:action)', via: [:get, :post, :patch]
end
