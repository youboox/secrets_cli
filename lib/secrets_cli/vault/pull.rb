module SecretsCli
  module Vault
    class Pull < SecretsCli::Vault::Read
      attr_reader :secrets_file, :secrets_dir

      def initialize(options)
        super
        SecretsCli::Check::Secrets.new(options).call
        @secrets_file = options.secrets_file || config.secrets_file
        @secrets_dir = options.secrets_dir || '.'
      end

      private

      def command
        secrets = super
        compare(secrets) unless options.ci_mode
        write(secrets)
        secrets
      end

      def compare(secrets)
        diff = TTY::File.diff(secrets_file, secrets, verbose: false)
        return if diff == ''
        prompt.ok("There are some differences between #{secrets_file} and vault:")
        pretty_diff(diff)
        exit 0 unless prompt.yes?("Are you sure you want to override #{secrets_file}?")
      end

      def write(secrets)
        print_verbose("Writing to #{secrets_file}")
        File.open(secrets_path, 'w') { |file| file.write(secrets) }
        File.chmod(0600, secrets_path)
      end

      def secrets_path
        @secrets_path ||= File.join(secrets_dir, secrets_file)
      end
    end
  end
end
