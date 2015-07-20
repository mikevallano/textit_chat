Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      # somebody wants to start chatting, but they haven't said anything
      post 'textit_new_chat' => "textit#new_chat"

      # message received
      post 'textit_new_message' => "textit#new_message"

      # payment received.
      post 'textit_new_order' => "textit#new_order"
    end
  end

  resources :consultation_questions

  resources :health_problems

  resources :follow_up_questions

  resources :push_notifications do
    collection do
      get 'push'
    end
  end

  resources :faqs
  # TODO remove these, required due to some weird behavior using respond_with
  # it tried to find *_url so easiest to just do basic scaffolding routes for now
  resources :chats
  resources :messages
  resources :orders


  resources :clients do
    collection do
      post 'register_for_general_info'
    end
  end

  get 'order_updates/create'

  get 'orders' => "orders#index"

  devise_for :users
  resources :users

  root 'pages#index'

  get "chats" => "chats#index"

  post 'messages' => "messages#create"
  get 'messages' => "messages#index"

  get 'orders' => "orders#index"

  post 'order_updates' => "order_updates#create"
end
