class User
  attr_reader :member, :bike
  def initialize(member: false)
    @member = member
  end

  def member?
    member == true
  end

  def rent(bike)
    @bike = bike
    @bike.rent_at = Time.now
  end
end
