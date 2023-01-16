Rails.application.routes.draw do
  resources :users
  resources :login

  # retrieve posts sorted in order
  namespace :get_posts do
    resource :newest
    resource :oldest
    resource :most_likes
    resource :most_dislikes
  end

  # actions of posts
  resources :posts do
    resource :like, controller: 'post_likes'
    resource :dislike, controller: 'post_dislikes'
    resource :save, controller: 'post_saves'
    namespace :get_post_replies do
      resource :newest
      resource :oldest
      resource :most_likes
      resource :most_dislikes
    end
  end

  # retrieve posts by categories sorted in order
  namespace :categories do
    resources :newest, controller: 'newests'
    resources :oldest, controller: 'oldests'
    resources :most_likes
    resources :most_dislikes
  end

  resources :replies do
    resource :like, controller: 'reply_likes'
    resource :dislike, controller: 'reply_dislikes'
    namespace :get_sub_replies do
      resource :newest
      resource :oldest
      resource :most_likes
      resource :most_dislikes
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
