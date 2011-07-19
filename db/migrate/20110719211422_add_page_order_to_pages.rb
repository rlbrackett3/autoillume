class AddPageOrderToPages < ActiveRecord::Migration
  def change
    add_column :pages, :page_order, :integer, default: 0
  end
end
