class AddAdminIdIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :admin_id
  end
end
