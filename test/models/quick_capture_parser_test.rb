require "test_helper"

class QuickCaptureParserTest < ActiveSupport::TestCase
  test "extracts title tags due date and priority" do
    parsed = QuickCaptureParser.parse("Comprar paprica amanha 18h #casa !")

    assert_equal "Comprar paprica amanha 18h !", parsed[:title]
    assert_equal ["casa"], parsed[:tags]
    assert_equal "high", parsed[:priority]
    assert parsed[:due_at].present?
  end
end
