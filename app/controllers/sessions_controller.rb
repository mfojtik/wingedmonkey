# Copyright 2012-2013 Red Hat, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

class SessionsController < ApplicationController
  layout "login"
  skip_before_filter :require_provider_authentication, :load_quotas

  def new
  end

  def create
    if current_provider.valid_credentials?(params)
      session[:current_provider_creds] = params
      return_to = session.delete(:return_to) || root_url
      redirect_to return_to
    else
      flash[:error] = _("Invalid cloud credentials")
      render "new"
    end
  end

  def destroy
    session.delete(:current_provider_creds)
    session.delete(:current_provider_id)
    redirect_to login_path
  end
end
