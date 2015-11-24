class Ability
  # the ideas are based on the cancancan gem
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

  def initialize(user)
    @user = user
  end

  def can?(obj, actn)
    obj.can?(actn.to_sym, @user)
  end

  def authorize!(obj, actn)
    unless obj.can?(actn.to_sym, @user)
      raise "not authorzied to #{@actn} #{@obj}"
    end
    true
  end
end


module DSpace
  module Rest
    class DSpaceObj
      def can?(actn, user)
        return true if user    # anything if logged in
        return rights.find_index(actn)
      end
    end
  end
end

module  ActiveRecord
  class Base
    def can?(actn, user)
      return user  # anything if logged in - nothing otherwise
    end
  end
end
