$(document).ready(function () {
$('body').on('su', '.mmm', function(event) {
  event.preventDefault();
  var serializedData = $('#new_comment').serializeArray()
  $.ajax({
    type: "POST",
      url: '/comments',
    data: serializedData,
    success: function(response)
    {
      var obj = response;

      if(obj["status"]==200)
      {
          $('#new_comment')[0].reset();

           var table = $('.comments')[0]
           var row = table.insertRow(obj['task_count']);
           row.id = "comment"+obj['comment']['id']
           var cell1 = row.insertCell(0);
           var cell2 = row.insertCell(1);
           var cell3 = row.insertCell(2);



           cell1.innerHTML = obj['comment']['name'];
           cell2.innerHTML = obj["comment"]["user"];
           cell3.innerHTML = obj["comment"]["created_at"];}

    }
  });
});
});
