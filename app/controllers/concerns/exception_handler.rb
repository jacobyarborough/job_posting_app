module ExceptionHandler 
  extend ActiveSupport::Concern

  included do 
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_json(object: { message: e.message }, status: :not_found)
    end 

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_json(object: { message: e.message }, status: :unprocessable_entity)
    end 

    rescue_from ActionController::ParameterMissing do |e|
      render_json(object: { message: e.message }, status: :bad_request)
    end 

    rescue_from OpenURI::HTTPError do |e|
      next
    end 
  end
end