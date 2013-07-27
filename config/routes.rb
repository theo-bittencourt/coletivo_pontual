ColetivoPontual::Application.routes.draw do
  root to: 'application#index'

  resources :devices do
    get 'tracked_index_stream', on: :collection
    get 'tracker', on: :member
  end
end
