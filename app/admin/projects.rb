ActiveAdmin.register Project do



# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name,:project_users_attributes
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  f.semantic_errors
  f.inputs do
    f.input :name
  end
  f.has_many :project_users,heading: 'Project_Managers', allow_destroy: true  do |user|
    data = User.where(role: "employee").map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
    user.input :user_id, :label => 'Project_Manager', :as => :select, :collection => data
  end
  f.actions
end

controller do

  after_create do
    if !params[:project][:project_users_attributes].nil?
      project_users_attributes = params[:project][:project_users_attributes]
      project = Project.last
      data = []
      project_users_attributes.each do |f|
         id =  f[1][:user_id]
         if !data.include? id
           project.project_users.build(user_id: id,assigned_by:current_user.id, designation: "PM").save
           data.push(id)
           debugger
         end
       end
    end
  end

after_update do
  if !params[:project][:project_users_attributes].nil?
    project_users_attributes = params[:project][:project_users_attributes]
    project = Project.find_by(name: params[:project][:name])
    data =  project.project_users.where(designation:'PM').pluck(:user_id)
    debugger
    project_users_attributes.each do |f|
      if f[1][:_destroy] == '1'
        id =  f[1][:id]
        ProjectUser.delete(id)
        data.delete(id.to_i)
        debugger
      end

      if f[1][:_destroy].nil?
        id =  f[1][:user_id]
       if !data.include? id
         project.project_users.build(user_id: id,assigned_by:current_user.id, designation: "PM").save
         data.push(id)
         debugger
       end

      end
     end
  end
end

end





end
