class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.text :body
      t.integer :position, default: 0
      t.references :post

      t.timestamps
    end
  end
end
