class ClaimRepository
  def build(attributes)
    Claim.new(attributes)
  end

  def get_claim_with_flights(id)
    Claim.includes(:flights).find_by(id: id)
  end

  def find_by_id(id)
    Claim.find_by(id: id)
  end

  def update!(object, attributes)
    object.assign_attributes(attributes)
    save!(object)
  end

  def save!(object)
    object.save!
  end
end
