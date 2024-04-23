$(document).ready(function () {
  $("#today-btn").on("click", function (e) {
    const date = new Date();
    let day = date.getDate();

    const p_id = $(e.target).attr("data-patient-id");

    console.log("Working", day, p_id);

    $.ajax({
      url: `http://localhost:3000/patients/${p_id}/slot_display`,
      method: "POST",
      data: { selected_day: day },
      dataType: "html",
      success: function (result) {
        $("#current_slots").html(result);
      },
    });
  });
  $("#tomo-btn").on("click", function (e) {
    const date = new Date();
    let day = date.getDate() + 1;
    const p_id = $(e.target).attr("data-patient-id");
    console.log("Working", day, p_id);
    $.ajax({
      url: `http://localhost:3000/patients/${p_id}/slot_display`,
      method: "POST",
      data: { selected_day: day },
      dataType: "html",
      success: function (result) {
        console.log();
        $("#current_slots").html(result);
      },
    });
  });
});

// console.log(result);
// console.log(result["id"]);
// // alert(result["name"]);
// var html = `<li><strong>Name: </strong> ${result["name"]}<br><strong>Year: </strong>  ${result["year"]} <br><strong>Singer: </strong>  ${result["singer"]} <br></li>`;
// $("ul").append(html);
// // window.location = `http://localhost:3000/tracks/${result["id"]}`;
