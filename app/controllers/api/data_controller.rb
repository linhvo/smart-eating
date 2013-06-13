require 'ostruct'

class Api::DataController < ActionController::Base

  respond_to :json, :xml

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_handler

  def unit
    @units = Unit.all
  end

  private

  def not_found_handler(exception)
    respond_to do |format|
      format.all { render status: :not_found }
    end
  end
end

