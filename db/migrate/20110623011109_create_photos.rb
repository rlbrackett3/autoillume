class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.integer :width
      t.integer :height
      t.string :orientation
      t.references :section

      t.timestamps
    end
  end
end
