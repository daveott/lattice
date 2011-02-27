module Lattice
  VERSION = "0.0.1"

  autoload :Header, "lattice/header"
  autoload :SubstitutionProxy, "lattice/substitution_proxy"

  def sendgrid_recipients(*addresses)
    sendgrid_header.recipients = *addresses
  end

  def sendgrid_substitute(original)
    sendgrid_header.substitute(original)
  end

  def sendgrid_category(name)
    sendgrid_header.category = name
  end

  def x_smtp_api_headers
    sendgrid_header.to_json
  end

  private

  def sendgrid_header
    @sendgrid_header ||= Lattice::Header.new
  end
end
