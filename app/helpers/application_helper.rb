# frozen_string_literal: true

module ApplicationHelper
  def json_response(message: '', data: {}, status: :ok)
    render json: { message: message, data: data }, status: status
  end

  def record_not_found(exception)
    json_response(message: 'error', data: [exception.message], status: :not_found)
  end

  def unprocessable(exception)
    json_response(message: "error", data: exception.record.errors.full_messages, status: :unprocessable_entity)
  end

  def standard_error(exception)
    json_response(message: 'error', data: [exception.message], status: :internal_server_error)
  end
end
