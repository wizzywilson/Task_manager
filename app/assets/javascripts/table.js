$(document).ready(function () { 
  $('body').on('click','.delete',function(event){
    event.preventDefault();
    var result = confirm("Want to delete?");
    if (result) {
      $.ajax({
        url: "/tasks/"+this.id,
        dataType: "json",
        type: "DELETE",
        success: function(response)
        {
          $("#row"+response['id']).hide();
        }
      });
    }

  });

  $('body').on('click','.view',function(event){
    event.preventDefault();
      $.ajax({
        url: "/tasks/"+this.id,
        dataType: "script",
        type: "GET"
      });


  });

  $('body').on('click','.edit',function(event){
    event.preventDefault();
    $.ajax({

      url: "/tasks/"+this.id,
      dataType: "json",
      type: "GET",
      success: function(response)
      {
        var obj = response;
        $('#add_task').click();
        $('#task_update').show();
        $('#task_submit').hide();
        $('#task_update').attr('name',obj["task"]["id"]);
        $('[name="project_user[user_id]"]').val(obj["project_user"]["user_id"]).trigger('change.select2');
        $('[name="project_user[task][name]"]').val(obj["task"]["name"]);
        $('#project_user_task_status').val(obj["task"]["status"]).trigger('change');
        $('#project_user_task_start_date').val(obj["task"]["start_date"]);
        $('#project_user_task_end_date').val(obj["task"]["end_date"]);
      }
    });
  });
});
