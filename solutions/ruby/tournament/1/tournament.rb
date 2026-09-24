=begin
Write your code for the 'Tournament' exercise in this file. Make the tests in
`tournament_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/tournament` directory.
=end
class Tournament
  HEADER = "Team                           | MP |  W |  D |  L |  P"
  
  def self.tally(input)
    new.tally(input)
  end
  
  def initialize
    @teams = Hash.new { |hash, name| hash[name] = Team.new(name) }
  end
  
  def tally(input)
    parse_input(input)
    rows = sort_teams.map(&:repr)
    return ([HEADER] + rows).join("\n") +"\n"
  end

  def parse_input(input)
    lines = input.split("\n")

    lines.each do |line|
      parse_line(line)
    sort_teams
    end  
  end

  def parse_line(line)
    team1_name, team2_name, result = line.split(";", 3)

    unless team1_name && team2_name && result
    raise ArgumentError, "Invalid game line: #{line.inspect}"
    end

    team1 = @teams[team1_name]
    team2 = @teams[team2_name]
    
    case result
      when 'win'
        team1.add_result("win")
        team2.add_result("loss")
      when 'loss'
        team1.add_result("loss")
        team2.add_result("win")
      when 'draw'
        team1.add_result("draw")
        team2.add_result("draw")
    end
  end

  def sort_teams
    @teams.values.sort_by { |team| [-team.points, team.name] }
  end
    
end

class Team
  attr_reader :name
  
  def initialize(name)
    @name = name
    @wins = 0
    @draws = 0
    @losses = 0
  end

  def matches
    @wins + @draws + @losses
  end

  def points
    3* @wins + @draws
  end

  def add_result(result)
    case result
      when "win"  then @wins += 1
      when "draw" then @draws += 1
      when "loss" then @losses += 1
      else raise ArgumentError, "Unknown result: #{result}"
    end
  end

  def repr
    format(
      "%-30s | %2d | %2d | %2d | %2d | %2d",
      @name, matches, @wins, @draws, @losses, points
    )
end
end
  