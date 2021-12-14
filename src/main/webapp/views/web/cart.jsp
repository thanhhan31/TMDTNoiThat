<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>GIỎ HÀNG</title>

<fmt:setLocale value="vi_VN" />
<script src="<c:url value="/scripts/web/cart.js"/>" type="text/javascript"></script>

<style>
	.my-checkbox {
	  	width: 20px;
	  	height: 20px;
	    border-radius: 50%;
	    border: 1px solid #ddd;
	}
	td {
		text-align: center;
		vertical-align: middle!important;
	}
	th {
		text-align: center;
		vertical-align: middle!important;
	}
</style>

<form method="post">
	<div class="row">
		<div class="col">
			<table class="table table-striped">
				<thead class="thead-dark">
					<tr>
						<th style="display:none"></th>
						<th class="col-*-auto"><input type="checkbox" id="checkAllProductCart" class="my-checkbox" onchange="checkAll(this.checked);"></th>
						<th class="col-2"></th>
						<th class="col-*-auto">Tên sản phẩm</th>
						<th class="col-*-auto">Đơn giá</th>
						<th class="col-*-auto">Số lượng</th>
						<th class="col-*-auto">Thành tiền</th>
						<th class="col-*-auto"></th>
					</tr>
				</thead>
	
				<tbody>
					<c:choose>
						<c:when test="${usercarts.size() > 0}">
							<c:forEach items="${usercarts}" var="pc">
								<tr>
									<td style="display:none" id="priceId${pc.getProduct().id}">${pc.getProduct().getUnitPrice()}</td>
									<td>
										<input type="checkbox" class="my-checkbox" name="idProduct" value="${pc.getProduct().id}" onchange="isCheckAll(); updateTotalPrice();">
									</td>
									<td>
										<c:choose>
											<c:when test="${pc.getProduct().getProductImages().size() > 0}">
												<img class="my-img-cart" src="${pc.getProduct().getProductImages().get(0).imageLink}">
											</c:when>
											<c:otherwise>
												<img class="my-img-cart" width="100%" height="100%"
													src="https://upload.wikimedia.org/wikipedia/commons/6/6a/A_blank_flag.png">
											</c:otherwise>
										</c:choose>
									</td>
									<td><a href="${pageContext.request.contextPath}/productdetail?id=${pc.getProduct().getId()}" target="_blank">${pc.getProduct().getName()}</a></td>
									<td><fmt:formatNumber value="${pc.getProduct().getUnitPrice()}" type="currency" /></td>
									<td>
										<input type="number" class="form-control mr-auto ml-auto" min="1" max="${pc.getProduct().getAvailableQuantity()}" value="${pc.getQuantity()}"
											onblur="adjustProductCart(this, ${pc.getProduct().id})" style="width: 75px;">
										<small class="text-muted text-center">${pc.getProduct().getAvailableQuantity()} sản phẩm có sẵn</small>
										
									</td>
									<td id="finalPriceId${pc.getProduct().id}">
										<fmt:formatNumber value="${pc.getProduct().getUnitPrice() * pc.getQuantity()}" type="currency" />
									</td>
									<td>
										<button type="button" class="btn btn-danger" id="btn-remove-product-cart"
											onClick="deleteProductFromCart(this, ${pc.getProduct().id})">
											<i class="fa fa-trash" aria-hidden="true"></i>
										</button>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<td colspan="7" class="text-center">Không có dữ liệu</td>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<hr class="solid">
	<c:if test="${unavailableProductCarts.size() > 0}">
		<div class="row">
			<div class="col">
				<div class="card">
					<div class="card-header">
						<h4>Sản phẩm vô hiệu hóa/hết hàng</h4>
					</div>
					<div class="card-body">
						<c:forEach items="${unavailableProductCarts}" var="u" varStatus="loop">
							<div class="row">
								<div class="col-*-4">
									<c:choose>
		                          		<c:when test="${u.getProduct().getProductImages().size() > 0 }">
		                          			<img class="my-img-cart" src="${u.getProduct().getProductImages().get(0).getImageLink()}">
		                          		</c:when>
		                          		<c:otherwise>
		                          			<img src="https://pbs.twimg.com/profile_images/1321517203397771266/Ifgafw1e_400x400.jpg">
		                          		</c:otherwise>
		                          	</c:choose>
								</div>
								<div class="col" style="text-align: center;align-self: center;">${u.getProduct().getName()}</div>
								<div class="col-*-auto">
									<div class="center-div">
										<button type="button" class="btn btn-danger" id="btn-remove-product-cart"
											onClick="deleteProductFromCart(this, ${u.getProduct().id});">
											<i class="fa fa-trash"></i>
										</button>
									</div>
								</div>
							</div>
							<c:if test="${!loop.last}">
								<hr class="solid">
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<hr class="solid">
	</c:if>
	
	<div class="row ">
		<c:if test="${not empty errorMsg }">
			<div class="col">
				<p class="text-danger">*${errorMsg}</p>
			</div>
		</c:if>
		<div class="col text-right">
			<h4>
				<span id="totalPrice" class="label label-default"></span>
			</h4>
		</div>
	</div>

	<br>
	<div class="row">
		<div class="col">
			<a class="btn btn-secondary btn-block btn-lg" href="${pageContext.request.contextPath}/products" role="button">Tiếp tục mua sắm</a>
		</div>
		<div class="col">
			<button type="submit" class="btn btn-primary btn-block btn-lg btn" name="userChange" value="new">Đặt hàng</button>
		</div>
	</div>

</form>