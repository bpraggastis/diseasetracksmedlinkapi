$(function(){

  $("#select-outbreak").click(function(){
    console.log("clicked");
    $("#outbreak-query-box").slideToggle();
  });

  var toggle_selector = function(item){
    if(item.hasAttribute('selected'))
      { item.removeAttr('selected');}
    else
      {item.attr('selected', true);}
  }

  var add_outbreak = function(e){
    item = $(e.target);
    toggle_selector(item);
    name = item.html();
    category = item.attr('data-category');
    var new_item = '<li data-category="' + category + '" >'+ name +
      '</li>';
    $('#list-of-choices').append(new_item);
  };


  $( "#startdatepicker" ).datepicker({
    dateFormat: 'M d, yy',
    changeMonth: true,
    changeYear: true,
    yearRange: "1979:2015",
    defaultDate: "Jan 1, 1979"
  });

  $( "#enddatepicker" ).datepicker({
    dateFormat: 'M d, yy',
    changeMonth: true,
    changeYear: true,
    yearRange: "1979:2015",
  });

  var params = location.search;
  var outbreakId = params.match(/outbreak_id=(\d*)/);
  var diseaseId = params.match(/disease_id=(\d*)/);
  var placeId = params.match(/place_id=(\d*)/);
  var startDate = params.match(/start_date=(.*)\&end/);
  var endDate = params.match(/end_date=(.*)\&commit/);

  if (outbreakId !== null)
    {
      var p = outbreakId[1];
      var outbreakOption = $('option[class="outbreak-selection"][value="'+p+'"]');
      outbreakOption[0].selected = true;
    };
  if (diseaseId !== null)
    {
      var p = diseaseId[1];
      var diseaseOption = $('option[class="disease-option"][value="'+p+'"]');
      diseaseOption[0].selected = true;
    };
   if (placeId !== null)
     {
       var p = placeId[1];
       var placeOption = $('option[class="place-selection"][value="'+p+'"]');
       placeOption[0].selected = true;
     };
   if (startDate !== null && startDate[1] !== "")
     {
       var re = /(\w+)\+(\d+)%2C\+(\d{4})/;
       var newStartDate = startDate[1].replace(/(\w+)\+(\d+)%2C\+(\d{4})/g,'$1 $2, $3');
       var startField = $('input[name="start_date"]');
       startField.val(newStartDate);
     }
   if (endDate !== null && endDate[1] !== "")
     {
       var re = /(\w+)\+(\d+)%2C\+(\d{4})/;
       var newEndDate = endDate[1].replace(/(\w+)\+(\d+)%2C\+(\d{4})/g,'$1 $2, $3');
       var endField = $('input[name="end_date"]');
       endField.val(newEndDate);
     }


});
