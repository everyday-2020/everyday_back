class AddClipToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :clip, :string
  end
end
