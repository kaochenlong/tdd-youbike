require 'bike'
require 'rental'
require 'timecop'

RSpec.describe Bike do
  context '會員計費' do
    let(:user) { User.new(member: true) }
    let(:rental) { Rental.new(user) }

    it "前 30 分鐘 5 元" do
      # Act
      rental.rent(subject)
      Timecop.travel(20 * 60) # 經過 20 分鐘
      rental.return(subject)

      # Assert
      expect(subject).to be_returned
      expect(subject.rental_duration_seconds).to be 1200
      expect(rental.charge).to be 5
    end

    it "超過 30 分鐘，但於 4 小時內還車，費率為每 30 分鐘 10 元" do
      # Act
      rental.rent(subject)
      Timecop.travel(140 * 60) # 經過 2 小時 20 分（140 分鐘）
      rental.return(subject)

      # Assert
      # 前 30 分鐘 5 元
      # 剩餘 110 分鐘每 30 分鐘 10 元，小計 40 元
      # 共計 5 + 40 = 35 元
      expect(rental.charge).to be 45
    end

    it "超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元" do
      # Act
      rental.rent(subject)
      Timecop.travel(375 * 60) # 經過 6 小時 15 分（375 分鐘）
      rental.return(subject)

      # Assert
      # 前 30 分鐘 5 元
      # 剩餘 345 分鐘，前 4 小時每 30 分鐘 10 元，小計 80 元
      #               後 105 分鐘，每 30 分鐘 20 元，小計 80 元
      # 共計 5 + 80 + 80 = 165 元
      expect(rental.charge).to be 165
    end

    it "超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價" do
      # Act
      rental.rent(subject)
      Timecop.travel(637 * 60) # 經過 10 小時 37 分後（637 分鐘）
      rental.return(subject)

      # Assert
      # 前 30 分鐘 5 元
      # 剩餘 607 分鐘，前 4 小時每 30 分鐘 10 元，小計 80 元
      #               後 4 小時每 30 分鐘 20 元，小計 160 元
      # 超時 127 分鐘，每 30 分鐘 40 元，小計 200 元
      # 共計 5 + 80 + 160 + 200 = 445 元
      expect(rental.charge).to be 445
    end
  end

  context '非會員計費' do
    # it "4 小時內，費率為每 30 分鐘 10 元"
    # it "超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元"
  end
end
