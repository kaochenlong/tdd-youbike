class User
  attr_reader :member, :bike
  def initialize(member: false)
    @member = member
  end

  def member?
    member == true
  end
end

