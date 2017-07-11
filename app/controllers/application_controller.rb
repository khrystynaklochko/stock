# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :ensure_json

  def ensure_json
    render json: { message: 'Wrong content-type header' }, status: 406 && return unless request.content_type == 'application/json'
  end
end
