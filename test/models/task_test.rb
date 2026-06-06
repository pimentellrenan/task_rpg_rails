require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "completion awards xp once" do
    user = User.create!(email: "test@example.com", password: "senha123456", password_confirmation: "senha123456")
    task = user.tasks.create!(title: "Resolver uma pendencia")

    task.complete!
    task.complete!

    assert_equal 1, task.xp_events.where(reason: "complete_task").count
    assert user.total_xp.positive?
  end
end
