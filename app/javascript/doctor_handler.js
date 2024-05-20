$(document).ready(function () {
  $("#doctor_register_form").on("submit", function (event) {
    event.preventDefault();
   
    var formData = new FormData($("#doctor_register_form")[0]);
    var fileInput = $("#doctor_picture")[0];
    if (fileInput.files && fileInput.files[0]) {
      formData.append("doctor_picture", fileInput.files[0]);
    }
    $.ajax({
      url: `http://localhost:3000/doctors`,
      method: "POST",
      data: formData,
      dataType: "html",
      processData: false,
      contentType: false,
      success: function (result) {
        $("#exampleModal").modal("hide");
        $("#display-doctors-div").append(result);
        $("#doctor_register_form")[0].reset();
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error("Error adding doctor:", textStatus, errorThrown);
      },
    });
  });

  $("#display-doctors-div").on("click", ".delete-button", function (event) {
    event.preventDefault();
    event.stopPropagation();
    var deleteButton = $(this);
    var docObject = deleteButton.data("doc");
    const doctor_id = docObject.id;
    $.ajax({
      url: `http://localhost:3000/doctors/${doctor_id}`,
      method: "DELETE",
      dataType: "html",
      processData: false,
      contentType: false,
      success: function (data) {
        deleteButton.closest("tr").remove();
        event.preventDefault();
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error("Error deleting doctor:", textStatus, errorThrown);
      },
    });
  });

    $("#display-doctors-div").on("click", ".edit-button", function(event) {
         event.preventDefault();
         event.stopPropagation();
         var editButton = $(this);
         var doctorId = $(this).data('doctor-id');
         var doctorName = $(this).data('doctor-name');
         var doctorPhone = $(this).data('doctor-phone');
         var doctorEmail = $(this).data('doctor-email');
      
         var doctorConsultationFee = $(this).data('doctor-consultation-fee');
         var doctorYearsOfExperience = $(this).data('doctor-experience');
   
         $('#doctor_name').val(doctorName);
         $('#doctor_email').val(doctorEmail);
         $('#doctor_phone_number').val(doctorPhone);
      
         $('#doctor_consultation_fee').val(doctorConsultationFee);
         $('#doctor_years_of_experience').val(doctorYearsOfExperience);
         $('#editDoctorModal').modal('show');
          
          $("#edit_form").on("submit", function (event) {
           event.preventDefault();
           event.stopPropagation();
           var formData = new FormData($("#edit_form")[0]);  
           console.log(formData);
             
           $.ajax({
               url: `http://localhost:3000/doctors/${doctorId}`,
               method: "PATCH",
               data: formData, 
               dataType: "html",
               processData: false, 
               contentType: false,
               success: function (result) {
                 console.log(result);
                  editButton.closest("tr").html(result);
                   $("#editDoctorModal").modal("hide");
                  
               },
           });
           });     
   
         
       });

});
