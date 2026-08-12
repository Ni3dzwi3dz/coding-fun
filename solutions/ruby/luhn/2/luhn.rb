=begin
Write your code for the 'Luhn' exercise in this file. Make the tests in
`luhn_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/luhn` directory.
=end
class Luhn
  def self.valid?(string)
    string
    .gsub(/\s/,"")
    .tap { |s| return false unless s[/\A\d\d+\z/] }
    .reverse
    .chars
    .map.with_index { |s, i| i.odd? ? s.to_i * 2 : s.to_i}
    .map { |d| d>9 ? d - 9: d}
    .sum % 10 == 0    
  end
 
end
