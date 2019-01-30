$(document).ready(function () {
  $(".myselect").select2();

  $('body').on('submit',"#new_project_user",function(event) {
    $("#task_name_error")[0].innerHTML=""
    $("#task_start_date_error")[0].innerHTML=""
    $("#task_end_date_error")[0].innerHTML=""

    var serializedData = $("#new_project_user").serializeArray();
    event.preventDefault();
    $.ajax({
           url: '/create_project_user_task',
           data: serializedData, // serializes the form's elements. {'test': test}
           type: "POST",
           dataType: "json",
           success: function(response)
           {

             var obj = response;

             if(obj["status"]==200)
             {

                 $('#close_modal').click();
                 $("#new_project_user")[0].reset();
                  var table = $('table')[0]
                  var row = table.insertRow($('tr').length);
                  row.id = "row"+obj['task']['id']
                  var cell1 = row.insertCell(0);
                  var cell2 = row.insertCell(1);
                  var cell3 = row.insertCell(2);
                  var cell4 = row.insertCell(3);
                  var cell5 = row.insertCell(4);
                  var cell6 = row.insertCell(5);
                  var cell7 = row.insertCell(6);
                  var cell8 = row.insertCell(7);
                  var cell9 = row.insertCell(8);

                  cell1.innerHTML = $('tr').length-1;
                  cell2.innerHTML = obj['task']['name'];
                  cell3.innerHTML = obj["project_user"]["user"]["email"];
                  cell4.innerHTML = obj["project_user"]["assigner"]["email"];
                  cell5.innerHTML = obj["project_user"]["designation"];
                  cell6.innerHTML = obj['task']['status'];
                  cell7.innerHTML = obj['task']['start_date'];
                  cell8.innerHTML = obj['task']['end_date'];
                  cell9.innerHTML = "<a class ='edit' id="+obj['task']['id']+" href='#' >edit</a> /<a class ='delete' id="+obj['task']['id']+" href='#' >delete</a>"

              }
              else if (obj["status"]==400) {
                // $('#task_error').html(obj['error']);
                obj = obj.error
                for (var key in obj) {
                  if (obj.hasOwnProperty(key)) {
                    var val = obj[key];
                    if(key=="tasks.name"){
                      $("#task_name_error")[0].innerHTML=val;

                    }
                    else if (key=="tasks.date") {
                      $("#task_start_date_error")[0].innerHTML=val;

                    }
                    else if (key=="tasks.start_date") {
                      $("#task_start_date_error")[0].innerHTML=val;

                    }
                    else if (key=="tasks.end_date") {
                      $("#task_end_date_error")[0].innerHTML=val;

                    }
                  }
                  }
              }

           }
    });
  });

  $('body').on('click','#task_update',function(event) {
    $("#task_name_error")[0].innerHTML=""
    $("#task_start_date_error")[0].innerHTML=""
    $("#task_end_date_error")[0].innerHTML=""

    var serializedData = $('#new_project_user').serializeArray();
    event.preventDefault();
    $.ajax({
      type: "PATCH",
      url: '/tasks/'+this.name,
      data: serializedData,
      success: function(response)
      {
         $('#close_modal').click();
        task = response.task
        project_user = response.project_user
      $('#row'+task.id+' td' )[1].innerHTML = task.name
      $('#row'+task.id+' td' )[2].innerHTML = project_user.user.email
      $('#row'+task.id+' td' )[3].innerHTML = project_user.assigner.email
      $('#row'+task.id+' td' )[4].innerHTML = project_user.designation
      $('#row'+task.id+' td' )[5].innerHTML = task.status
      $('#row'+task.id+' td' )[6].innerHTML = task.start_date
      $('#row'+task.id+' td' )[7].innerHTML = task.end_date

      }
    });

  });

  $('.modal').on('hidden.bs.modal', function (e) {
         $("#new_project_user")[0].reset();
         $("#task_name_error")[0].innerHTML=""
         $("#task_start_date_error")[0].innerHTML=""
         $("#task_end_date_error")[0].innerHTML=""
  })

  $('.datepicker').datepicker();

});
