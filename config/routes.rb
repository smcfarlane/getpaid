Rails.application.routes.draw do

  post 'invites/invite_vendor'

  post 'invites/invite_client'

  resources :invoices

  post 'invoices/:id/paid' => 'invoices#paid', as: :invoice_paid

  post 'invoices/:id/email_client' => 'invoices#email_client', as: :email_client_invoice

  authenticated do
    root :to => 'organizations#index', as: :auth_root
  end

  root 'welcome#home'

  get 'welcome/features'

  get 'welcome/about'

  resources :organizations, except: [:new, :destroy] do
    resources :projects
  end

  get 'get-client-projects' => 'projects#get_client_projects'

  get 'organization/project/new' => 'projects#new_without_org', as: :new_project_without_org

  get 'organization/new/client' => 'organizations#new_client'
  get 'organization/new/vendor' => 'organizations#new_vendor'
  delete 'organization/destroy/client/:id' => 'organizations#destroy_client', as: :destroy_client_org
  delete 'organization/destroy/vendor/:id' => 'organizations#destroy_vendor', as: :destroy_vendor_org
  post 'organization/add_to_project' => 'organizations#add_to_project', as: :add_org_to_project

  devise_for :accounts

end
