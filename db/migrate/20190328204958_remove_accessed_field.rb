class RemoveAccessedField < ActiveRecord::Migration[5.2]
  def change
    remove_column :url_accesses, :accessed
  end
end
