class CreateUrlAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :url_accesses do |t|
      t.references :url, foreign_key: true
      t.datetime :accessed
      t.string :ip

      t.timestamps
    end
  end
end
