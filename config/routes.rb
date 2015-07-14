Rails.application.routes.draw do

  get 'users/all' => 'users#index_all', as: :all_users
  post 'user/:id/make_manager' => 'users#make_manager', as: :make_user_manager
  resources :users

  post 'invite_user' => 'invites#invite', as: :invite_user

  post 'invoices/:id/paid' => 'invoices#paid', as: :invoice_paid
  post 'invoices/:id/email_client' => 'invoices#email_client', as: :email_client_invoice
  resources :invoices

  authenticated do
    root :to => 'organizations#index', as: :auth_root
  end

  get 'get-client-projects' => 'projects#get_client_projects'

  get 'organization/project/new' => 'projects#new_without_org', as: :new_project_without_org
  get 'organization/new/client' => 'organizations#new_client'
  get 'organization/new/vendor' => 'organizations#new_vendor'
  get 'organization/new/your-organization' => 'organizations#new_your_org', as: :new_your_org
  delete 'organization/destroy/client/:id' => 'organizations#destroy_client', as: :destroy_client_org
  delete 'organization/destroy/vendor/:id' => 'organizations#destroy_vendor', as: :destroy_vendor_org
  post 'organization/add_to_project' => 'organizations#add_to_project', as: :add_org_to_project

  resources :organizations, except: [:new, :destroy] do
    resources :projects
  end

  devise_for :accounts, controllers: { registrations: "registrations" }

  root 'welcome#home'
  get 'welcome/features'
  get 'welcome/about'

end
