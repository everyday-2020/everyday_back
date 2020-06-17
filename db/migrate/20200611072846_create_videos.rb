class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.integer :clicks
      t.string :file_path
      t.integer :length
      t.string :invite_code

      t.timestamps
    end
  end
end
