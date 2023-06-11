class CreateStellarfyAnchors < ActiveRecord::Migration[7.0]
  def change
    create_table :stellarfy_anchors do |t|
      t.string :name
      t.string :toml_url
      t.boolean :enabled
      t.jsonb :parsed_toml
      t.datetime :toml_parsed_at
      t.string :network

      t.timestamps
    end
  end
end
