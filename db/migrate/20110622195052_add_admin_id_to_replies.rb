class AddAdminIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :admin_id, :integer
  end
end
