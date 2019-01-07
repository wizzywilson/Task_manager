ActiveAdmin.register Project do



# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name,:user_projects
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
  f.has_many :project_users,heading: 'Project_Managers'  do |user|
    user.input :user_id, :label => 'Project_Manager', :as => :select, :collection => User.where(role: "employee").map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
  end
  f.actions
end

controller do

#   def create
#       @project = Project.new(name:  params[:project][:name])
#         if @project.valid?
#           if !params[:project][:user_projects_attributes].nil? && !params[:project][:user_projects_attributes]["0"][:admin_user_id].empty?
#             @project.save
#             params[:project][:user_projects_attributes].each do |f|
#               id = params[:project][:user_projects_attributes][f][:admin_user_id]
#               ProjectUser.create(user_id: id, project_id: Project.find_by(name:params[:project][:name]).id, assigned_by:current_user.id, designation: "PM") if !id.empty?
#             end
#               redirect_to :admin_user_projects
#           elsesss
#             redirect_to :back
#             flash[:error] = "Select a Project Manager"
#           end
#         else
#           flash[:error] = "Enter a valid name"
#           redirect_to :back
#         end
# end
#
#
# end

before_create do
  if params[:project][:user_projects_attributes].nil?
            flash[:error] = "Select a Project Manager"
  end
end

  #   @project = Project.create(name:  params[:project][:name])
  #
  #   if @project.valid? && !params[:project][:user_projects_attributes].nil?
  #   params[:project][:user_projects_attributes].each do |f|
  #         id = params[:project][:user_projects_attributes][f][:admin_user_id]
  #         UserProject.create(admin_user_id: id, project_id: Project.find_by(name:params[:project][:name]).id, assigned_by:current_admin_user.id, designation: "PM")
  #         redirect_to :admin_user_projects
  #   end
  # else
  #   if !@project.valid?
  #     flash[:error] = "Enter a valid "
  #   else
  #     flash[:error] = "Select a Project Manager"
  #   end
  #   redirect_to :back
  # end
  # end
end



  show do
     attributes_table do
       row :name
     end
  end


end
