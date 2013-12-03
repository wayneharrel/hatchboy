Hatchboy::Application.routes.draw do
  root :to => "pages#home"
  devise_for :accounts, :controllers => {:registrations => "registrations"}
  
  get "account", :to => "accounts#show", :as => :account
  get "account/edit", :to => "accounts#edit", :as => :edit_account
  put "account", :to => "accounts#update"
  patch "account", :to => "accounts#update"
  
  get "dashboard", :to => "pages#dashboard", :as => :account_dashboard
  
  get "company", :to => "companies#show"
  get "company/edit", :to => "companies#edit", :as => :edit_company
  put "company", :to => "companies#update"
  patch "company", :to => "companies#update"
  
end
