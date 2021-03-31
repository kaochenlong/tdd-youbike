require 'bike'
require 'rental'
require 'timecop'

RSpec.describe Bike do
  context '會員計費' do
    let(:user) { User.new(member: true) }

    it '前 30 分鐘 5 元' do
      # Arrange
      rental = Rental.new(user)

      # Act
      rental.add(subject)
      Timecop.travel(20 * 60) # 20 分鐘後
      rental.return(subject)

      # Assert
      expect(rental.charge).to be 5
    end

    # it "超過 30 分鐘，但於 4 小時內還車，費率為每 30 分鐘 10 元"
    # it "超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元"
    # it "超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價"
  end

  context '非會員計費' do
    # it "4 小時內，費率為每 30 分鐘 10 元"
    # it "超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元"
  end
end
