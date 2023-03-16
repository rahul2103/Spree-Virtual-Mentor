Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resource :mentors, only: [] do
      get 'chat'
      get 'fine-tunes-lists'
      post 'create-fine-tunes'
      put 'set-completions-model'
      get 'completions'
    end
  end
end
