class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :manager
      can :manage, User if user.has_role?(:manager, user.organization)
      can :manage, Organization if user.has_role?(:manager, user.organization)
      can :manage, Project if user.has_role?(:manager, user.organization)
      can :manage, Invoice if user.has_role?(:manager, user.organization)
    elsif user.has_role? :employee
      projects = Project.with_role(:employee, user).pluck(:id)
      can :manage, User, id: user.id
      can :manage, Project, id: projects
      can :manage, Organization, id: Organization.with_role(:employee, user).pluck(:id)
      can :manage, Invoice, id: Invoice.where(project_id: projects)
    else
      can :read, :all
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
