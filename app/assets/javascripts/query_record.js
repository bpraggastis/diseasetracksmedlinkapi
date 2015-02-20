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
      var queryRecord = $("#query-form").serializeObject();
      var url = $(this).data("url");
      // var url = this.data("url");
      $.post("/query_records", {query: queryRecord}, function(){
        window.location.reload();
      });
  });

  $("#update-query-record").click(function(){
    var queryRecord = $("#query-form").serializeObject();
    $.post("/query_records/", {query: queryRecord});
  });

});
