class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ] # this line means don't have to be logges in to see index page

  def index
    if current_user
      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end
      @tenant = Tenant.current_tenant
      params[:tenant_id] = @tenant.id
    end
  end
end
