class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    return @line.split(":")[1].strip
  end

  def log_level
    return @line.split(":")[0].gsub(/[\[\]]/,'').downcase.strip
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
