class ClaimsController < ApplicationController
  def create
    result = ::Services::V1::CreateClaim.new.call(params)
    render json: result.response_body, status: result.response_code
  end

  def index
    @claims = Claim.all
    render json: @claims
  end

  def show
    result = ::Services::V1::GetClaim.new.call(params)
    render json: result.response_body, status: result.response_code
  end
end
