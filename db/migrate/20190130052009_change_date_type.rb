class ChangeDateType < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :start_date, :date
    change_column :tasks, :end_date, :date
  end

  def down
    change_column :tasks, :start_date, :string
    change_column :tasks, :end_date, :string
  end
end
