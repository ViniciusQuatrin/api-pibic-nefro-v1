# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
  end
end
