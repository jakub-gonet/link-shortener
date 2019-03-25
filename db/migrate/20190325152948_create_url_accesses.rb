class CreateUrlAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :url_accesses do |t|
      t.timedate :accessed
      t.string :ip

      t.timestamps
    end
  end
end
