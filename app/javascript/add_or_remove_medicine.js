
$(document).ready(function () {
    $("#submit-btn").on("click", function (e) {
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
                
               console.log(result);
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
    console.log(medicine_id);

    $.ajax({
        url: `http://localhost:3000/medicines/${medicine_id}`,
        method: "DELETE",
        dataType: "html",
        processData: false,
        contentType: false, 
        success: function (data) {
            deleteButton.closest("tr").remove();
            event.preventDefault();
            console.log("Medicine deleted successfully!");
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error deleting doctor:", textStatus, errorThrown); 
        }
    });
});
     
});