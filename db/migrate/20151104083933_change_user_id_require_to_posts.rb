class ChangeUserIdRequireToPosts < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, :integer, :required => true
  end
end
