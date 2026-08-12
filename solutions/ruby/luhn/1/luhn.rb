=begin
Write your code for the 'Luhn' exercise in this file. Make the tests in
`luhn_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/luhn` directory.
=end
class Luhn
  def self.valid?(string)
    return false if string.gsub(" ","").length < 2 || string.match(/[^0-9 ]/)
  
    double_every_other_digit(str_to_array(string)).sum % 10 == 0
  end

  def self.str_to_array(str)
    str.scan(/\d/).map(&:to_i)
  end

  def self.double_every_other_digit(arr)
    arr.reverse.map.with_index do |digit, index|
      index.odd? ? duplicate_digit(digit) : digit
    end.reverse
  end

  def self.duplicate_digit(digit)
    times_two = digit * 2
    times_two > 9 ? times_two -9 : times_two
  end
end
