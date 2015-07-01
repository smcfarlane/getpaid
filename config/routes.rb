Rails.application.routes.draw do

  resources :invoices

  post 'invoices/:id/paid' => 'invoices#paid', as: :invoice_paid

  post 'invoices/:id/email_client' => 'invoices#paid', as: :email_client_invoice

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

  devise_for :accounts

end
