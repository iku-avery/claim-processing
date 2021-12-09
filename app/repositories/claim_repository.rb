class ClaimRepository
  def build(attributes)
    Claim.new(attributes)
  end

  def save!(object)
    object.save!
  end
end
