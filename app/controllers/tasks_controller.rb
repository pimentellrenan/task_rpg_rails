class TasksController < ApplicationController
  before_action :require_authentication
  before_action :set_task, only: %i[edit update destroy complete reopen]

  def index
    @tasks = current_user.tasks.open.includes(:project, :tags).order(Arel.sql("due_at IS NULL"), :due_at, created_at: :desc)
  end

  def create
    parsed = QuickCaptureParser.parse(task_params[:title])
    @task = current_user.tasks.new(task_params.merge(parsed.slice(:title, :due_at, :priority)))

    if @task.save
      attach_tags(@task, parsed[:tags])
      XpLedger.award!(user: current_user, task: @task, points: 3, reason: "capture_task")
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: "Nao consegui criar tarefa"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete
    @task.complete!
    redirect_back fallback_location: root_path
  end

  def reopen
    @task.update!(status: "active", completed_at: nil)
    redirect_back fallback_location: root_path
  end

  def destroy
    @task.destroy!
    redirect_back fallback_location: root_path
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :notes, :status, :priority, :due_at, :project_id)
  end

  def attach_tags(task, names)
    names.each do |name|
      tag = current_user.tags.find_or_create_by!(name:)
      task.tags << tag unless task.tags.exists?(tag.id)
    end
  end
end
