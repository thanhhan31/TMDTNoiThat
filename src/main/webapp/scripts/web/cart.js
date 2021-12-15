$(document).ready(function() {
	updateTotalPrice();
});

function deleteProductFromCart(btn_row, idProduct) {
	$.ajax({
		url: contextPath + '/api/cart-api',
		type: 'POST',
		data: { "type": "adjust", "idProduct": idProduct },
		dataType: "json",
		async: false,
		success: function(respone) {
			if (respone.status !== "200") {
				$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi xóa sản phẩm khỏi giỏ hàng";
				$("#modalErrorMessage")[0].innerText = respone.message;
				$("#errorModal").modal('show');
			}
			else {
				var row = btn_row.parentNode.parentNode;
				row.parentNode.removeChild(row);
				updateTotalPrice();
				$("#cartQuantity")[0].innerText = getCartQuantity();
			}
		},
		error: function(xhr) {
			if (xhr.status !== 401) {
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

function adjustProductCart(input_element, idProduct) {
	if (input_element.value < 1) {
		return;
	}
	$.ajax({
		url: contextPath + '/api/cart-api',
		type: 'POST',
		data: { "type": "adjust", "idProduct": idProduct, "quantity": input_element.value },
		dataType: "json",
		success: function(respone) {
			if (respone.status !== "200") {
				$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thay đổi số lượng sản phẩm trong giỏ hàng";
				$("#modalErrorMessage")[0].innerText = respone.message;
				$("#errorModal").modal('show');
				input_element.value = input_element.getAttribute('value')
			}
			else {
				var formatter = new Intl.NumberFormat('vi-VN', {
					style: 'currency',
					currency: 'VND',
				});
				var final_price_elelemt = document.getElementById("finalPriceId" + idProduct);
				var price = Number(document.getElementById("priceId" + idProduct).innerHTML);
				final_price_elelemt.innerText = formatter.format(price * input_element.value);
				updateTotalPrice();
				$("#cartQuantity")[0].innerText = getCartQuantity();
				input_element.setAttribute('value', input_element.value)
			}
		},
		error: function(xhr) {
			if (xhr.status !== 401) {
				$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thay đổi số lượng sản phẩm trong giỏ hàng";
				$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idProduct: ' + idProduct;
				$("#errorModal").modal('show');
			}
			else {
				window.location.href = contextPath + '/login?returnUrl=' + window.location.href;
			}
		}
	});
}

function updateTotalPrice() {
	var totalPrice = 0.0;
	var table_rows = document.getElementsByClassName("table")[0].rows;
	for (var i = 1; i < table_rows.length; i++) {
		if (table_rows[i].cells[1].getElementsByTagName('input')[0].checked){
			var price = Number(table_rows[i].cells[0].innerHTML);
			var qty = Number(table_rows[i].cells[5].getElementsByTagName('input')[0].value);
			totalPrice += price * qty;
		}
	}

	var formatter = new Intl.NumberFormat('vi-VN', {
		style: 'currency',
		currency: 'VND',
	});

	document.getElementById("totalPrice").innerText = "Tổng tiền: " + formatter.format(totalPrice);
}

function checkAll(checked){
	var formatter = new Intl.NumberFormat('vi-VN', {
		style: 'currency',
		currency: 'VND',
	});
	var table_rows = document.getElementsByClassName("table")[0].rows;
	if (!checked){
		for (var i = 1; i < table_rows.length; i++) {
			table_rows[i].cells[1].getElementsByTagName('input')[0].checked = false;
		}
		document.getElementById("totalPrice").innerText = "Tổng tiền: " + formatter.format('0');
	}
	else {
		var totalPrice = 0.0;
		for (var i = 1; i < table_rows.length; i++) {
			var price = Number(table_rows[i].cells[0].innerHTML);
			var qty = Number(table_rows[i].cells[5].getElementsByTagName('input')[0].value);
			totalPrice += price * qty;
			table_rows[i].cells[1].getElementsByTagName('input')[0].checked = true;
		}
		document.getElementById("totalPrice").innerText = "Tổng tiền: " + formatter.format(totalPrice);
	}
}

function isCheckAll(){	
	let allChecked = true;
	let table_rows = document.getElementsByClassName("table")[0].rows;
	for (let i = 1; i < table_rows.length; i++) {
		if (!table_rows[i].cells[1].getElementsByTagName('input')[0].checked){
			allChecked = false;
			break;
		}
	}
	
	if (allChecked){
		$('#checkAllProductCart')[0].checked = true;
	}
	else {
		$('#checkAllProductCart')[0].checked = false;
	}
}
