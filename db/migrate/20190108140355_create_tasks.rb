class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :project_user
      t.string :name
      t.integer :status
      t.string :start_date, default: 'Not Assigned'
      t.string :end_date, default: 'Not Assigned'
      t.timestamps
    end
  end
end
