class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :title
      t.string :description
      t.date :complete_at
      t.string :invited_code
      t.string :category

      t.timestamps
    end
  end
end
