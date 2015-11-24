class Ability
  # the ideas are based on the cancancan gem
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

  def initialize(user)
    @user = user
  end

  def can?(obj, actn)
    return true if actn.nil?
    return obj.can?(actn.to_sym, @user)
  end

  def authorize!(obj, actn)
    unless actn.nil? || obj.can?(actn, @user)
      raise "not authorzied to #{actn} #{obj}"
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

    class Community
      def self.can?(actn, user)
        return false if user.nil?
        return actn != :create
      end
    end

    class Collection
      def self.can?(actn, user)
        # can't ever do anything on Collection class
        # create/delete done in relation to Community objects
        return false
      end
    end

  end
end

