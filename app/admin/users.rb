ActiveAdmin.register User do
  permit_params :email, :role, :first_name, :last_name

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :role
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :role
    end
    f.actions
  end

end
