# frozen_string_literal: true

module ApplicationHelper
  def json_response(data: {}, status: 200)
    render json: data, status: status
  end
end
