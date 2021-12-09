class ClaimsController < ApplicationController
  def create
    result = ::Services::V1::CreateClaim.new.call(params)
    render json: result
  end

  def index
    @claims = Claim.all
    render json: @claims
  end
end
