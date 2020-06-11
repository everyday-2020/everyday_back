class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :nickname
      t.string :pw_digest
      t.string :profile_pic
      t.Date :created_at
      t.Date :modified_at

      t.timestamps
    end
  end
end
