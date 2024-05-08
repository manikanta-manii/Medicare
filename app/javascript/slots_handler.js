
$(document).ready(function () {
  const dates = getDatesForNextThreeDays();
  $("#today-btn").on("click", function (e) {
    let today = dates.today;
    const d_id = $(e.target).attr("data-doctor-id");
    console.log("hi");
    $.ajax({
      url: `http://localhost:3000/slots/display`,
      method: "POST",
      data: { selected_day: today, id: d_id  },
      dataType: "html",

      success: function (result) {
        
        $("#current_slots").html(result);
      },
    });
  });
  $("#tomo-btn").on("click", function (e) {
   let tomorrow = dates.tomorrow;
    const d_id = $(e.target).attr("data-doctor-id"); 
    $.ajax({
      url: `http://localhost:3000/slots/display`,
      method: "POST",
      data: { selected_day: tomorrow, id: d_id },
      dataType: "html",
      success: function (result) {
        $("#current_slots").html(result);
      },
    });
  });

  $("#nextday-btn").on("click", function (e) {
  
    let day_after_tomorrow = dates.dayAfterTomorrow;
    const d_id = $(e.target).attr("data-doctor-id");
    
    $.ajax({
      url: `http://localhost:3000/slots/display`,
      method: "POST",
      data: { selected_day: day_after_tomorrow, id: d_id },
      dataType: "html",
      success: function (result) {
        $("#current_slots").html(result);
      },
    });
  });

  function getDatesForNextThreeDays() {
  const today = new Date();

  const getDateWithOffset = (offset) => {
    const newDate = new Date(today.getTime() + offset * 24 * 60 * 60 * 1000); 
    return newDate.toLocaleDateString(); 
  };

  const todayString = getDateWithOffset(0);
  const tomorrowString = getDateWithOffset(1);
  const dayAfterTomorrowString = getDateWithOffset(2);

  return {
    today: todayString,
    tomorrow: tomorrowString,
    dayAfterTomorrow: dayAfterTomorrowString
  };
}

});
