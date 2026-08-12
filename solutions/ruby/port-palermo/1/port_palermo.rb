module Port
  # TODO: define the 'IDENTIFIER' constant
  IDENTIFIER = :PALE

  def self.get_identifier(city)
    city[..3].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    ["OIL","GAS"].include?(ship_identifier.to_s[..2]) ? :A : :B
  end
end
