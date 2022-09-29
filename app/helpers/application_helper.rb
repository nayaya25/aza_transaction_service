# frozen_string_literal: true

module ApplicationHelper
  def json_response(message: '', data: {}, status: 200)
    render json: { message: message, data: data }, status: status
  end
end
