RSpec::Matchers.define :have_consecutive_lines_matching do |*regexen|
  def compute_match(string, regexen)
    if regexen.empty?
      return [true]
    end

    regex = regexen.shift
    m = string.match(regex)
    if m
      remaining = m.post_match
      newline_i = remaining.index("\n")+1
      remaining = remaining[newline_i..-1]
      compute_match(remaining, regexen)
    else
      return [false, regex, string]
    end
  end

  match do |actual|
    compute_match(actual, regexen.flatten).shift
  end

  failure_message_for_should do |actual|
    _, failed_regex, failed_string = compute_match(actual, regexen.flatten)
    "expected #{failed_regex.inspect} to match #{failed_string.inspect}"
  end

  diffable
end
