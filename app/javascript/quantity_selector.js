$(document).ready(function () {
  $(".add-button").click(function (event) {
    event.preventDefault();
    const medId = $(this).data("med");
    const quantity = $(this).closest("tr").find(".quantity").text();

    medicineData = {
      medicine_id: medId,
      medicine_quantity: quantity,
    };
    console.log(medicineData);

    $.ajax({
      url: `http://localhost:3000/cart_items`,
      method: "POST",
      data: medicineData,
      dataType: "html",
      success: function (result) {
        console.log(result);
        $("#count").html(result);
      },
    });
  });

  $(".quantity-counter .increment").click(function () {
    var currentQuantity = parseInt($(this).siblings(".quantity").text());
    var maxQuantity = parseInt($(this).data("med-quantity"));
    if (currentQuantity < maxQuantity) {
      $(this)
        .siblings(".quantity")
        .text(currentQuantity + 1);
    }
  });

  $(".quantity-counter .decrement").click(function () {
    var currentQuantity = parseInt($(this).siblings(".quantity").text());
    if (currentQuantity > 1) {
      $(this)
        .siblings(".quantity")
        .text(currentQuantity - 1);
    }
  });
});
