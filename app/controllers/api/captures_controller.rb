module Api
  class CapturesController < ActionController::API
    def create
      user = User.find_by(api_token: bearer_token)
      return render json: { error: "unauthorized" }, status: :unauthorized unless user

      parsed = QuickCaptureParser.parse(params.require(:text))
      task = user.tasks.create!(
        title: parsed[:title],
        due_at: parsed[:due_at],
        priority: parsed[:priority],
        status: "inbox"
      )
      parsed[:tags].each do |name|
        task.tags << user.tags.find_or_create_by!(name:)
      end
      XpLedger.award!(user:, task:, points: 3, reason: "capture_task")

      render json: { id: task.id, title: task.title, xp: user.total_xp }, status: :created
    end

    private

    def bearer_token
      request.authorization.to_s.delete_prefix("Bearer ").presence
    end
  end
end
