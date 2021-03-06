require 'yaml'
require 'tty-prompt'
require 'tty-file'
require 'open3'
require 'singleton'
require 'vault'
require 'secrets_cli/helpers'
require 'secrets_cli/configuration'
require 'secrets_cli/init'
require 'secrets_cli/check/secrets'
require 'secrets_cli/check/vault'
require 'secrets_cli/prompts/secrets_file'
require 'secrets_cli/prompts/secrets_storage_key'
require 'secrets_cli/vault/base'
require 'secrets_cli/vault/auth'
require 'secrets_cli/vault/read'
require 'secrets_cli/vault/pull'
require 'secrets_cli/vault/push'
require 'secrets_cli/version'

# require 'pry'

module SecretsCli
  SECRETS_CONFIG_FILE = '.secrets'.freeze
  SECRETS_FIELD = :secrets
end
