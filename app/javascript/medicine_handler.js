$(document).ready(function () {
    $("#medicine_form").on("submit", function (e) {
        e.preventDefault();
        var formData = new FormData($("#medicine_form")[0]);      
        $.ajax({
            url: `http://localhost:3000/medicines`,
            method: "POST",
            data: formData, 
            dataType: "html",
            processData: false, 
            contentType: false,
            success: function (result) {  
                $("#exampleModal").modal("hide");
                $("#display-medicines-div").append(result);
                $("#medicine_form")[0].reset();
            },
        });     
    });
 
$("#display-medicines-div").on("click", ".delete-button", function(event) {
    event.preventDefault();
    var deleteButton = $(this); 
    var medObject = deleteButton.data("med");
    const medicine_id = medObject.id;

    $.ajax({
        url: `http://localhost:3000/medicines/${medicine_id}`,
        method: "DELETE",
        dataType: "html",
        processData: false,
        contentType: false, 
        success: function (data) {
            deleteButton.closest("tr").remove();
            event.preventDefault();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error deleting doctor:", textStatus, errorThrown); 
          }
      });
   });
     

   $("#display-medicines-div").on("click", ".edit-button", function(event) {
    event.preventDefault();
     var editButton = $(this);
    var medicineId = $(this).data('medicine-id');
    var medicineName = $(this).data('medicine-name');
    var medicineDesc = $(this).data('medicine-description');
    var medicinePrice = $(this).data('medicine-price');
    var medicineDosage = $(this).data('medicine-dosage');
    var medicineQuantity = $(this).data('medicine-quantity');


    console.log(medicineName);
    //$('#medicine_image').val(medicineImage);
    $('#medicine_name').val(medicineName);
    $('#medicine_description').val(medicineDesc);
    $('#medicine_dosage').val(medicineDosage);
    $('#medicine_price').val(medicinePrice);
    $('#medicine_quantity').val(medicineQuantity);


    $('#editMedicineModal').modal('show');
     
     $("#edit_form").on("submit", function (e) {
      e.preventDefault();
      var formData = new FormData($("#edit_form")[0]);      
      $.ajax({
          url: `http://localhost:3000/medicines/${medicineId}`,
          method: "PATCH",
          data: formData, 
          dataType: "html",
          processData: false, 
          contentType: false,
          success: function (result) {
             editButton.closest("tr").html(result);      
             $("#editMedicineModal").modal("hide");        
          },
      });
      });     

    
  });
});