
$(document).ready(function() {

    $('.feedback-button').click(function() {
      const appointmentId = $(this).data('appointmentId');
      $('#feedback').val('');  
       $('#rating').val('1');
  
      $('.confirm-feedback').click(function() {
  
      const cur_review = $('#feedback').val(); 
      const cur_rating = $('#rating').val(); 
  
      console.log("Review :", cur_review);
      console.log("Appointment:", appointmentId);
      console.log("Rating out of 5 :",cur_rating);
  
      const feedbackData = {
        review:cur_review,
        appointment_id:appointmentId,
        rating:cur_rating,
      }
  
      console.log(feedbackData);
      $.ajax({
              url: `http://localhost:3000/feedbacks`,
              method: "POST",
              data: feedbackData, 
              dataType: "html", 
              success: function (result) {  
                console.log(result);
                window.location.reload();
              },
          });
      });
    });
  });
  