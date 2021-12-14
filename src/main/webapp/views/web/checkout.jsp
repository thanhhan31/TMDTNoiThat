<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>CHECKOUT</title>
<fmt:setLocale value="vi_VN" />

<form action="${pageContext.request.contextPath}/api/processpayment" method="post">
	<div class="row">
		<div class="col">
			<div class="card w-100">
				<div class="card-header">
					<h5><i class="far fa-address-card"></i> Địa chỉ nhận hàng</h5>
				</div>
				<div class="card-body">
					<c:forEach items="${ships}" var="s" varStatus="loop">
						<div class="row">
							<div class="col-1 text-center">
								<input class="radio" type="radio" name="idShip" value="${s.getId()}" required>
							</div>
							<div class="col">
								${s.getAddress()}
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
	
	<c:forEach items="${sellers}" var="seller">
		<div class="row mt-3">
			<div class="col">
				<div class="card w-100">
					<div class="card-header">
						<h5><i class="fas fa-store"></i> ${seller.getUsername()}</h5>
					</div>
					<div class="card-body">
						<c:set var="splitterCheck" value="${0}" />
						<c:forEach items="${checkoutCarts}" var="productCart">
							<c:if test="${productCart.getProduct().getUser().getId() == seller.getId() }">
								<c:if test="${splitterCheck == 1}">
									<hr class="solid">
								</c:if>
								<c:set var="splitterCheck" value="${1}" />
								<div class="row">
									<div class="col">
										<div class="row">
											<div class="col-2">
												<c:choose>
													<c:when test="${productCart.getProduct().getProductImages().size() > 0 }">
														<img src="${productCart.getProduct().getProductImages().get(0).getImageLink()}" width="100"
															height="100">
													</c:when>
													<c:otherwise>
														<img src="https://pbs.twimg.com/profile_images/1321517203397771266/Ifgafw1e_400x400.jpg"
															width="100" height="100">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="col">
												${productCart.getProduct().getName()}
											</div>
										</div>
									</div>
									<div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
										<div class="container d-flex h-100">
											<div class="row align-self-center ml-auto">
												<p>
													<fmt:formatNumber value="${productCart.getProduct().getUnitPrice()}" type="currency" />
													<br />x${productCart.getQuantity()}
												</p>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
	
					<div class="card-footer">
						<div class="row">
							<div class="col text-right">
								<h5>Tổng tiền:
									<fmt:formatNumber value="${subTotalPrices.get(seller.getId())}" type="currency" />
								</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
	
	<div class="row mt-3">
		<div class="col">
			<div class="card w-100">
				<div class="card-header">
					<h5><i class="fas fa-money-bill-wave"></i> Phương thức thanh toán</h5>
				</div>
				<div class="card-body">
					<c:forEach items="${paymentmethods}" var="p" varStatus="loop">
						<div class="row">
							<div class="col-1 text-center">
								<input class="radio" type="radio" name="paymentType" value="${p.getId()}" required>
							</div>
							<div class="col">${p.getName()}</div>
						</div>
						<c:if test="${!loop.last}">
							<hr class="solid">
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="col text-right">
			<h3>Tổng tiền thanh toán:
				<fmt:formatNumber value="${totalPrice}" type="currency" />
			</h3>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4 ml-auto">
			<button type="submit" class="btn btn-success btn-block btn-lg">ĐẶT HÀNG</button>
		</div>
	</div>
</form>