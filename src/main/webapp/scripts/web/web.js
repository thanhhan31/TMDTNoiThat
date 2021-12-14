$(document).ready(function() {
	if ($('#userhref').length === 1){
		$("#cartQuantity")[0].innerText = getCartQuantity();
	}
});

function getCartQuantity() {
	var quantity = "0";
	$.ajax({
		url: contextPath + '/api/cart-api',
		type: 'GET',
		async: false,
		success: function(respone) {
			if (respone.status === "200") {
				quantity = respone.totalQuantity;
			}
		}
	});
	return quantity;
}

function addProductCart(idProduct, quantity) {
	$.ajax({
		url: contextPath + '/api/cart-api',
		type: 'POST',
		data: { "type": "add", "idProduct": idProduct, "quantity": quantity },
		dataType: "json",
		success: function(respone) {
			if (respone.status !== "200") {
				$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thêm sản phẩm vào giỏ hàng";
				$("#modalErrorMessage")[0].innerText = respone.message;
				$("#errorModal").modal('show');
			}
			else {
				$("#cartQuantity")[0].innerText = getCartQuantity();
				$("#modalInfoMessageTitle")[0].innerText = "Thành công";
				$("#modalInfoMessage")[0].innerText = "Thêm sản phẩm vào giỏ hàng thành công";
				$("#infoModal").modal('show');
			}
		},
		error: function(xhr) {
			if (xhr.status != 401) {
				$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi xóa sản phẩm khỏi giỏ hàng";
				$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idProduct: ' + idProduct;
				$("#errorModal").modal('show');
			}
			else {
				window.location.href = contextPath + '/login?returnUrl=' + window.location.href;
			}
		}
	});
}

function addProductCartWithInput(idProduct) {
	if ($('#quantity')[0].value === '')
		return;
	addProductCart(idProduct, $('#quantity')[0].value)
}
