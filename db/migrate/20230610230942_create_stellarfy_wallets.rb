class CreateStellarfyWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :stellarfy_wallets do |t|
      t.references :owner, polymorphic: true, null: true
      t.string :address
      t.string :seed
      t.string :network

      t.timestamps
    end
  end
end
