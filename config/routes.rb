Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resource :mentors, only: [] do
      get 'chat'
      get 'fine-tunes-lists'
      get 'model-list'
      put 'set-completions-model'
      put 'set-custom-model'
      post 'create-fine-tunes'
      post 'completions'
    end
  end
end
