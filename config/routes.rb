Rails.application.routes.draw do
  resources "ideas" 
  resources "categories" 
  
  # root "ideas#index"
end
