# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApplicationHelper

  before_action :throttle_ip

  rescue_from NameError, with: :standard_error
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected
  def throttle_ip
    return unless Rails.env.production?

    client_ip = request.env['REMOTE_ADDR']
    key = "count:#{client_ip}"
    count = REDIS.get(key)

    unless count
      REDIS.set(key, 0)
      REDIS.expire(key, THROTTLE_TIME_WINDOW)
      return true
    end

    if count.to_i >= THROTTLE_MAX_REQUESTS
      render json: {
               status: false,
               message: 'You have fired too many requests. Please wait for some time.'
             }, status: 429

      return
    end
    REDIS.incr(key)
    true
  end
end
