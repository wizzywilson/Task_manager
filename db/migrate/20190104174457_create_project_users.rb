class CreateProjectUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_users do |t|
      t.references :user,foreign_key: true, dependent: :destroy
      t.references :project, foreign_key: true, dependent: :destroy
      t.integer :assigned_by
      t.integer :designation
      t.timestamps
    end
  end
end
