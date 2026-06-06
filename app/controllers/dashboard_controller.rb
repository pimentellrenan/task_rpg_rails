class DashboardController < ApplicationController
  before_action :require_authentication

  def index
    @task = current_user.tasks.new
    @inbox = current_user.tasks.inbox.order(created_at: :desc).limit(8)
    @today = current_user.tasks.today.order(:due_at, :created_at)
    @week = current_user.tasks.week.order(:due_at, :created_at).limit(10)
    @overdue = current_user.tasks.overdue.order(:due_at)
    @projects = current_user.projects.order(:name)
    @badges = current_user.badge_awards.order(awarded_at: :desc)
  end
end
