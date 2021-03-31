class Rental
  attr_reader :user, :bike

  def initialize(user)
    @user = user
  end

  def add(bike)
    @bike = bike
    @bike.rent_at = Time.now
  end

  def return(bike)
    bike.return_at = Time.now
    @bike = nil
  end

  def charge
    5
  end
end