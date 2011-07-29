class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :external_links do |t|
      t.string :title
      t.string :url
      t.integer :link_order, default: 0
      t.string :description

      t.timestamps
    end
  end
end
