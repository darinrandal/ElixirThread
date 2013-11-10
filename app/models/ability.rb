class Ability
  include CanCan::Ability

  def initialize(user)
    if user
        if user.admin?
            can :manage, :all
        elsif user.moderator?
            can :manage, Post
        else
            can :create, Post
            can :edit, Post, :user_id => user.id
            can :update, Post, :user_id => user.id
        end
        
        can :report, Post
    end

    can :read, :all
  end
end
