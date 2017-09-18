class AddPubGuidToNews < ActiveRecord::Migration[5.1]
  def change
	add_column :news, :guid_hash, :integer, null: true, limit: 8 # Hash of GUID rss feed item
	add_column :news, :pub_time, 'timestamp with time zone', null: true
  end
end
