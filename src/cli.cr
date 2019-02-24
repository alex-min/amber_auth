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
AmberAuth::CLI::MainCommand.run ARGV
