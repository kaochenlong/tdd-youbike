class User
  attr_reader :member, :bike
  def initialize(options = {})
    @member = options[:member]
  end

  def member?
    member == true
  end
end

