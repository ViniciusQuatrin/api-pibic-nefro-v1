module Api::V1
  class ApiController < ApplicationController
    class ForbiddenAccess < StandardError; end
    include Authenticable

    include SimpleErrorRenderable
    self.simple_error_partial = "shared/simple_error"

    rescue_from ForbiddenAccess do
      render_error(message: "Forbidden access", status: :forbidden)
    end

    before_action :restrict_access_to_admin!

    private
    def restrict_access_to_admin!
      raise ForbiddenAccess unless Current.user.admin?
    end
  end
end
