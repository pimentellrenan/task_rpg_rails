class QuickCaptureParser
  TAG_PATTERN = /#([\p{Alnum}_-]+)/.freeze

  def self.parse(text)
    clean = text.to_s.squish
    {
      title: clean.gsub(TAG_PATTERN, "").squish,
      tags: clean.scan(TAG_PATTERN).flatten.map(&:downcase).uniq,
      due_at: detect_due_at(clean),
      priority: clean.match?(/!|urgente|hoje/i) ? "high" : "normal"
    }
  end

  def self.detect_due_at(text)
    hour = text[/\b(\d{1,2})h\b/, 1]&.to_i

    if text.match?(/\bamanha|amanhã\b/i)
      return Time.current.tomorrow.change(hour: hour || 9)
    end

    return Time.current.change(hour: hour || 18) if text.match?(/\bhoje\b/i)

    nil
  end
end
