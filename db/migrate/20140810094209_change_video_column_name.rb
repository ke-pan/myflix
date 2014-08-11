class ChangeVideoColumnName < ActiveRecord::Migration
  def change
    rename_column :videos, :cover_url, :small_cover
    rename_column :videos, :video_url, :large_cover
  end
end
