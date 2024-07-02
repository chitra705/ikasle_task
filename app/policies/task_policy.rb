class TaskPolicy < ApplicationPolicy
  def index?
    user.admin? || user.manager? || user.team_lead?
  end

  def show?
    user.admin? || user.manager? || user.team_lead? || user.team_member?
  end

  def create?
    user.admin? || user.manager? || user.team_lead?
  end

  def update?
    user.admin? || user.manager? || user.team_lead?
  end

  def destroy?
    user.admin? || user.manager? || user.team_lead?
  end

  def change_status?
    user.admin? || user.manager? || user.team_lead? || user.team_member?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.manager? || user.team_lead?
        scope.all
      else
        scope.where(assigned_to: user.id)
      end
    end
  end
end
