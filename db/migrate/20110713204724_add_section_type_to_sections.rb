class AddSectionTypeToSections < ActiveRecord::Migration
  def change
    add_column :sections, :section_type, :string
  end
end
