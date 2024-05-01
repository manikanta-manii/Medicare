
$(document).ready(function () {
    $("#submit-btn").on("click", function (e) {
        e.preventDefault();
        var formData = new FormData($("#doctor_register_form")[0]); 
        var fileInput = $("#doctor_picture")[0];
        if (fileInput.files && fileInput.files[0]) {
            formData.append('doctor_picture', fileInput.files[0]);
        }
        console.log(formData);
        $.ajax({
            url: `http://localhost:3000/manage_doctors`,
            method: "POST",
            data: formData, 
            dataType: "html",
            processData: false, 
            contentType: false,
            success: function (result) {  
                $("#display-doctors-div").append(result);
                $("#doctor_register_form")[0].reset();
               
            },
        });
        
    });
 
$("#display-doctors-div").on("click", ".delete-button", function(event) {
    event.preventDefault();
    var deleteButton = $(this); 

    var docObject = deleteButton.data("doc");
    const doctor_id = docObject.user_id;
    console.log(doctor_id);

    $.ajax({
        url: `http://localhost:3000/manage_doctors/${doctor_id}`,
        method: "DELETE",
        dataType: "html",
        processData: false,
        contentType: false, 
        success: function (data) {
            deleteButton.closest("tr").remove();
            event.preventDefault();
            console.log("Doctor deleted successfully!");
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error deleting doctor:", textStatus, errorThrown); 
        }
    });
});
     
});
