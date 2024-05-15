$(document).ready(function () {
 
  //changing the address select option
$('#deliveryAddress').on('click', function() {
    if (this.value === 'new') {
      $('#newAddressFields').show();
    } else {
      $('#newAddressFields').hide();
    }
  }); 

  //increment handler
$(".quantity-counter .increment").click(function () {
    var currentQuantity = parseInt($(this).siblings(".quantity").text());
    var maxQuantity = parseInt($(this).data("med-quantity"));
    var orderItemId = parseInt($(this).data("order-item-id"));
    var medPrice = parseInt($(this).data("med-price"));
    console.log(`Price - ${medPrice}`);
    console.log(`Increment - ${orderItemId}`);

    if (currentQuantity < maxQuantity) {
      $(this)
        .siblings(".quantity")
        .text(currentQuantity + 1);

        $(this)
          .closest("tr")
          .find(".item-quantity")
          .text(currentQuantity + 1);

          newPrice = parseInt($(this).siblings(".quantity").text()) * medPrice;
          console.log(`NEW PRICE AFTER INCREMNET ${newPrice}`);

          $(this)
          .closest("tr")
          .find(".item-price")
          .text(`${newPrice}.Rs`);


          $.ajax({
            url: `http://localhost:3000/order_items/${orderItemId}`,
            method: "PATCH",
            data: { quantity: "increment"},
            dataType: "html",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(
                  "X-CSRF-Token",
                  $('meta[name="csrf-token"]').attr("content")
                );
              },
            success: function (result) {
              console.log(result);
              
              $("#total_price").html(result);
            
            },
            error: function (xhr, status, error) {
              console.error(xhr.responseText); 
            }
          });
            }else{
              $("#display-div").html(
                `<div class="alert alert-danger alert-dismissible fade show" role="alert">
                       MAXIMUM QUANTITY REACHED
                 <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                 </div>`
              );
            }
        });


$(".quantity-counter .decrement").click(function () {
            var currentQuantity = parseInt($(this).siblings(".quantity").text());
            var orderItemId = parseInt($(this).data("order-item-id"));
            var medPrice = parseInt($(this).data("med-price"));
            console.log(`Price - ${medPrice}`);
            console.log(`DECREMENT - ${orderItemId}`);

            updateData = {
                  action: "decrement",
            }

            if (currentQuantity > 1) {
              $(this)
                .siblings(".quantity")
                .text(currentQuantity - 1);

                $(this)
                  .closest("tr")
                  .find(".item-quantity")
                  .text(currentQuantity - 1);
                newPrice = parseInt($(this).siblings(".quantity").text()) * medPrice;
                console.log(`NEW PRICE AFTER INCREMNET ${newPrice}`);

                  $(this)
                  .closest("tr")
                  .find(".item-price")
                  .text(`${newPrice}.Rs`);

                //ajax call

                $.ajax({
                url: `http://localhost:3000/order_items/${orderItemId}`,
                method: "PATCH",
                data: { quantity: "decrement"},
                dataType: "html",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(
                      "X-CSRF-Token",
                      $('meta[name="csrf-token"]').attr("content")
                    );
                  },
                success: function (result) {
                  console.log(result);
                $("#total_price").html(result);
                },
                error: function (xhr, status, error) {
                  console.error(xhr.responseText); 
                }
                });
                }
                  
                });



$("button.delete").click(function () {

              var orderItemId = parseInt($(this).data("order-item-id"));
              console.log(orderItemId);
              var deleteButton = $(this);
              var currentCount = parseInt($("#cart-count").text());

          $.ajax({
            url: `http://localhost:3000/order_items/${orderItemId}`,
            method: "DELETE",
            dataType: "html",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(
                  "X-CSRF-Token",
                  $('meta[name="csrf-token"]').attr("content")
                );
              },
            success: function (result) {

              console.log(result);
              if (result=="no items"){
                $("#whole-page").html(` <div>
                      <h3>Cart is Empty</h3>
                      <img src="https://cdni.iconscout.com/illustration/free/thumb/free-empty-cart-4085814-3385483.png?f=webp",alt="cart is empty">
                  </div>`)
                
                console.log("APPEND EMPTY CART");
              }
              else{
                    $("#checkout").html(result);
                  deleteButton.closest("tr").remove();
              }
              $("#cart-count").html(currentCount-1);
              
            },
            error: function (xhr, status, error) {
              console.error(xhr.responseText); 
            }
          });

          });

$('#submitButton').click(function(event) {
         event.preventDefault(); 
     var orderId = $('#submitButton').data('order-id');
      const deliveryAddressSelect = $('#deliveryAddress');
      const newAddressFields = $('#newAddressFields');
      const prescriptionInput = $('#prescription');

      let selectedValue = null;
      let newAddress = null;
      let prescriptionFile = null;

      if (deliveryAddressSelect.length) {
        selectedValue = deliveryAddressSelect.val();
      }

      if (newAddressFields.css('display') !== 'none') {
        const countryInput = $('#country').val();
        const stateInput = $('#state').val();
        const cityInput = $('#city').val();
        const streetInput = $('#street').val();

        newAddress = {
          country: countryInput,
          state: stateInput,
          city: cityInput,
          street: streetInput,
        };
      }

      if (prescriptionInput.length) {
        prescriptionFile = prescriptionInput[0].files[0];
      }

      console.log("Selected Address:", selectedValue);
      console.log("New Address:", newAddress);
      console.log("Prescription File:", prescriptionFile);
      
      const formData = new FormData();
      formData.append('prescription', prescriptionFile);
      formData.append('old',selectedValue);
      for (const key in newAddress) {
          if (newAddress.hasOwnProperty(key)) { 
            formData.append(`new[${key}]`, newAddress[key]);
          }
        }

      
        $.ajax({
            url: `http://localhost:3000/orders/${orderId}`,
            method: "PATCH",
            data: formData,
            contentType: false,
            processData: false, 
            beforeSend: function (xhr) {
                xhr.setRequestHeader(
                  "X-CSRF-Token",
                  $('meta[name="csrf-token"]').attr("content")
                );
              },
            success: function (result) {
              console.log(result);
              if (result=="ok"){
                window.location.href = `http://localhost:3000/orders/${orderId}`;
              }
              else{
                $("#close-btn").click();
                $("#display-div").html(
                    `<div class="alert alert-danger alert-dismissible fade show" role="alert">
              Order Failed to Place
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>`
                  );
              }
    
            },
            error: function (xhr, status, error) {
              console.error(xhr.responseText); 
            }
          });
    
  
         });

});
