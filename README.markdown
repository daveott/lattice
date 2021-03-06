### Lattice ###

WARNING: Lattice is currently under development and is not yet available as a gem. Proceed at your own risk.

Lattice is a small library for interacting with Sendgrid's [SMTP API](http://wiki.sendgrid.com/doku.php?id=smtp_api).

### Features ###

The biggest problem that Lattice solves is providing tokens to email templates for per email custom body content. The Sendgrid API allows you to setup an "X-SMTPAPI" email header in the form of a JSON string with tokens and list of substitutions for those tokens along with email recipients and various other keys such as a category for statistics reporting.

### About Sendgrid ###

"SendGrid is a cloud-based email service that delivers email on behalf of companies to increase deliverability and improve customer communications." It is reliable, inexpensive, and it has actionable metrics and statistics that can be viewed through their web console. It is also easy to setup in a rails project.

### Installation ###

Add this to your Gemfile.

`gem 'lattice'`

### Rails 3 Conguration ###

Add something like this to your environment:

    config.action_mailer.default_url_options = { :host => "my-domain.com" }
    config.action_mailer.delivery_method = :smtp

    credentials = YAML.load_file(Rails.root.join("config", "sendgrid.yml"))

    ActionMailer::Base.smtp_settings = {
      :address => "smtp.sendgrid.net",
      :port => '25',
      :domain => "my-domain.com",
      :authentication => :plain,
      :user_name => credentials["user_name"],
      :password => credentials["password"]
    }

### Usage ###

In a rails mailer class:

    class UserMailer < ActionMailer::Base
      include Lattice

      def welcome(addresses, tokens, ids)
        sendgrid_recipients(addresses)
        sendgrid_category("User Activations")
        sendgrid_substitute(:token).with(tokens).and(:user_id).with(ids)

        mail(:to => "noreply@my-domain.com", "X-SMTPAPI" => x_smtp_api_headers)
      end
    end

By including Lattice in your mailer action you have access to the following methods:

* sendgrid_recipients 
  An array of email addresses

* sendgrid_category
  A category string

* sendgrid_substitute 
  A token name
  You can also optionally chain additional tokens and substitutions with the "and" method. So you can say substitute any occurance of the token -token- with the values of the given array in order one per email.

* x_smtp_api_headers

### Authors ###

Robert Pitts (rbxbx)
Dave Ott (daveott)
