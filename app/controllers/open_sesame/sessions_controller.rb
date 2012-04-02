module OpenSesame
  class SessionsController < ApplicationController
    unloadable

    skip_before_filter :authenticate_opensesame!
    skip_authorization_check if defined?(CanCan)

    def new
      render :layout => 'open_sesame/application'
    end

    def create
      require 'rubygems'; require 'pry'; binding.pry
      warden.authenticate!(:scope => :opensesame)
      flash[:success] = "Welcome!"
      redirect_to main_app.root_url
    end

    def destroy
      warden.logout(:opensesame)
      flash[:notice] = "Logged out!"
      redirect_to main_app.root_url
    end

    def failure
      raise params.inspect
    end

  end
end
