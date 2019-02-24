require "cli"
require "yaml"
require "teeplate"
require "amber/exceptions/exceptions"
require "amber/cli/config"
require "amber/cli/generators/generator"
require "amber/environment"
require "amber/cli/commands"

module AmberAuth::CLI
  class MainCommand < ::Cli::Supercommand
    command_name "amber_auth"

    class Help
      title "\nAmber Auth CLI"
      header <<-EOS
        The amber_auth command generate authentication files for a user, it generates:
         - Signup view
         - Signin view
         - Forgotten password view & mailer
         - migrations

        Execute this command in your current directory

      EOS

      footer <<-EOS
      Example:
      crystal lib/amber_auth/src/cli.cr generate
      EOS
    end    
  end
end

module Amber::CLI
  class CrectoDevise < AuthBase
    directory "#{__DIR__}/../templates/devise/crecto"
  end
end

module Amber::CLI
  class GraniteDevise < AuthBase
    directory "#{__DIR__}/../templates/devise/granite"
  end
end


module Amber::CLI
  class Devise < Generator
    command :devise
    property auth : Generator

    def initialize(name, fields)
      super(name, fields)
      if config.model == "crecto"
        @auth = CrectoDevise.new(name, fields)
      else
        @auth = GraniteDevise.new(name, fields)
      end
    end

    def render(directory)
      auth.render(directory)
    end
  end
end

Amber::CLI::Devise.new("ff", [] of String).render("abc")

puts Amber::CLI::Generator.registered_commands
AmberAuth::CLI::MainCommand.run ARGV
