class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.references :task
      t.references :user
      t.timestamps
    end
  end
end
