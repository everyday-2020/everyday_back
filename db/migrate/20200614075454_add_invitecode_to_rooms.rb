class AddInvitecodeToRooms < ActiveRecord::Migration[6.0]
  def change
    remove_column :rooms, :invited_code
    add_column :rooms, :invite_code, :string, null: false
    add_index :rooms, :invite_code, unique: true
  end
end
