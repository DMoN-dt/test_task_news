class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.timestamps
	  t.string      :title
	  t.string      :text
	  t.string      :url
	  t.boolean     :is_top, default: false, null: false
	  t.column      :top_until, 'timestamp with time zone'
    end
  end
end
