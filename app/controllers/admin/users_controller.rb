module Admin
  class UsersController < Admin::ApplicationController
    def index
      @users = User.all
    end
  end
end
