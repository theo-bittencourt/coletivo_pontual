ColetivoPontual::Application.routes.draw do
  root to: 'application#index'

  get '/tracker' => 'application#tracker'
end
