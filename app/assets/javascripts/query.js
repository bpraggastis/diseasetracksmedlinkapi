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

});
