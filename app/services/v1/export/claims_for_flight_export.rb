require 'csv'

module Services
  module V1
    module Export
      class ClaimsForFlightExport
        COLUMNS = ['claim_id', 'email', 'first_name', 'last_name', 'flight_identifiers'].freeze
        class << self
          def export(claims)
            CSV.generate do |csv|
              csv << COLUMNS

              claims.each do |claim|
                csv << [ claim.id, claim.email, claim.first_name, claim.last_name, flight_identifiers(claim) ]
              end
              csv
            end
          end

          private

          def flight_identifiers(claim)
            claim.flights.pluck(:flight_identifier).flatten
          end
        end
      end
    end
  end
end
