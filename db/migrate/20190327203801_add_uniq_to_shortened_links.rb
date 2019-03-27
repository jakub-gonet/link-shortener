class AddUniqToShortenedLinks < ActiveRecord::Migration[5.2]
  def change
    add_index :urls, :shortened_url, unique: true
  end
end
