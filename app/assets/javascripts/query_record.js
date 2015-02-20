$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$(function(){
  $("#save-query-record").click(function(){
      var queryRecord = $(".query-form form").serializeObject();
      var ajaxUrl = $(this).data("url");
      console.log(queryRecord);
      $.post(ajaxUrl, {query: queryRecord}, function(){
        window.location.reload();
      });
  });

  $("#update-query-record").click(function(){
    var queryRecord = $(".query-form form").serializeObject();
    var ajaxUrl = $(this).data("url");
    console.log("HEEEEREEE!!!");
    console.log(ajaxUrl);
    $.ajax(ajaxUrl,
            {type: 'PATCH',
            data: {query: queryRecord},
            success: function(){
              console.log("RAAAHHHHRRRR!");
              window.location.reload();
            }
          });
  });

  $("#delete-query-record").click(function(){
    var ajaxUrl = $(this).data("url");
    $.ajax(ajaxUrl,
          {type: 'DELETE',
          success: function(){
            window.location.reload();
          }}
        );
  });

});
