class ChangeRoomNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:rooms, :title, false)
    change_column_null(:rooms, :complete_at, false)
    change_column_null(:rooms, :invited_code, false)

    change_column_null(:users, :username, false)
    change_column_null(:users, :nickname, false)
  end
end
