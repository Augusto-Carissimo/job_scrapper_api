class RenameTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :jobs, :positions
  end
end
