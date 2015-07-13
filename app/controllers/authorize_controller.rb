class AuthorizeController < ApplicationController
   def authorize_admin
     raise ActionController::RoutingError.new('Not Found') unless current_account.has_role? :admin
   end
end
