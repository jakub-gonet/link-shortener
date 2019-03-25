class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :base_url
      t.string :shortened_url

      t.timestamps
    end
  end
end
 