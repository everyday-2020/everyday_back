class RemovePwDigestFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :pw_digest, :string
  end
end
