require 'user'

RSpec.describe User do
  context '會員資格' do
    it '是會員' do
      user = User.new(member: true)

      expect(user).to be_member
    end

    it '不是會員（預設值）' do
      user = User.new

      expect(user).not_to be_member
    end
  end
end
