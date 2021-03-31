class Rental
  attr_reader :user, :bike

  def initialize(user)
    @user = user
  end

  def rent(bike)
    bike.rent!
    @bike = bike
  end

  def return(bike)
    bike.return!
  end

  def charge
    rental_duration_mins = (bike.rental_duration_seconds) / 60

    case rental_duration_mins
    when 0..30
      # 前 30 分鐘 5 元
      5
    when 31..240
      # 超過 30 分鐘，但於 4 小時內還車，費率為每 30 分鐘 10 元
      5 + ((rental_duration_mins - 30) / 30.0).ceil * 10
    when 241..480
      # 超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元
      5 + (4 * 2 * 10) + ((rental_duration_mins - (30 + 240)) / 30.0).ceil * 20
    else
      # 超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價
      5 + (4 * 2 * 10) + (4 * 2 * 20) + ((rental_duration_mins - (30 + 480)) / 30.0).ceil * 40
    end
  end
end