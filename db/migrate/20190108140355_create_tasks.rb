class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :project_user
      t.string :name
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
