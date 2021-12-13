class FlightsController < ApplicationController
  def export
    respond_to do |format|
      flight_identifier = params[:id]
      claims = Flight.with_eligible_claims.find_by(flight_identifier: flight_identifier).claims.includes(:flights)
      format.csv { send_data ::Services::V1::Export::ClaimsForFlightExport.export(claims), filename: "claims-by-flight-#{flight_identifier}-#{Date.today}.csv" }
    end
  end
end
