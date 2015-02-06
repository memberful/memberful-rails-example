module Admin
  class ApplicationController < ::ApplicationController
    layout "admin"

    before_action :authenticate_administrator!
  end
end
