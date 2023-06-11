module Stellarfy
  class Wallet < ApplicationRecord
    belongs_to :owner, polymorphic: true, optional: true

    def self.create_wallet(network, owner = nil)
      stellar_account = Stellar::Account.random
  
      Stellarfy::Wallet.create(
        owner: owner,
        address: stellar_account.keypair.address,
        seed: stellar_account.keypair.seed,
        network: network || Stellarfy::Networks::TESTNET
      )
    end

    def account
      @account ||= Stellar::Account.from_seed(seed)
    end
  
    def transactions
      client.transactions({
        account: account,
        order: :chronological
      })
    end

    def friendbot_fund
      return unless network == Stellarfy::Networks::TESTNET
  
      response = HTTParty.get("https://friendbot.stellar.org/?addr=#{address}")
      response.code == 200
    end

    private

    def client
      @client ||= network_client
    end

    def network_client
      case network
      when Stellarfy::Networks::TESTNET
        Stellar::Horizon::Client.default_testnet
      when Stellarfy::Networks::MAINNET
        Stellar::Horizon::Client.default
      when Stellarfy::Networks::LOCALHOST
        Stellar::Horizon::Client.localhost
      else
        raise "Unknown network: #{network}"
      end
    end
  end
end
