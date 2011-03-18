class Lattice::SubstitutionProxy
  attr_reader :header

  def initialize(original, header)
    @original = original
    @header = header
  end

  def original
    @original ||= original.to_s.gsub(/^|$/, header.substitution_marker)
  end

  def with(*replacements)
    self.tap { |proxy| header.substitutions[original] = *replacements }
  end

  def and(original)
    Lattice::SubstitutionProxy.new(original, header)
  end

end
