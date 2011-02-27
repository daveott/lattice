class Lattice::SubstitutionProxy
  attr_reader :original, :header

  def initialize(original, header)
    @original = "<#{original.to_s}>"
    @header = header
  end

  def with(*replacements)
    self.tap { |proxy| header.substitutions[original] = *replacements }
  end

  def and(original)
    SubstitutionProxy.new(original, header)
  end

end
