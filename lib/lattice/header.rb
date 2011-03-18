require 'json'

class Lattice::Header
  attr_accessor :data
  attr_reader :substitution_marker

  def initialize
    data ||= {}
    data["sub"] = {}
    data["to"] = []
    data["category"] = ""
  end

  def category
    data["category"]
  end

  def category=(name)
    data["category"] = name
  end

  def recipients=(*addresses)
    data["to"] = *addresses
  end

  def substitution_marker=(val)
    @substitution_marker ||= val
  end

  def substitute(original)
    Lattice::SubstitutionProxy.new(original, self)
  end

  def substitutions
    data["sub"]
  end

  def to_json
    JSON.generate(data).gsub(/(["\]}])([,:])(["\[{])/, '\\1\\2 \\3')
  end

  def to_s
    "X-SMTPAPI: #{to_json.gsub(/(.{1,72})( +|$\n?)|(.{1,72})/,'\\1\\3\n')}"
  end
end
