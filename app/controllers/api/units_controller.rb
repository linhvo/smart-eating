class Api::UnitsController < ActionController::Base
  respond_to :json, :xml

  def index
      @units = Unit.all
  end
end