class CreateUsersRoomsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :rooms, :users
  end
end
