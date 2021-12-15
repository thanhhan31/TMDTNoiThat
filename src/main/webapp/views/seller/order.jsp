<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<fmt:setLocale value="vi_VN" />

<title>Đơn hàng</title>

<style>
	.img-container {
	  width: 100%;
	}
	
	.img-container img {
	  max-height:100%;
	  max-width: 100%;
	}

</style>

<div class="card">
	<div class="card-header">
		<div class="row">
			<div class="col">
				<h3>DANH SÁCH ĐƠN HÀNG</h3>
			</div>
			<div class="d-flex flex-column mr-3">
				<div class="form-group form-inline">
					<label for="paginateSizeSelect">Hiển thị</label>
					<select class="form-control ml-1" id="paginateSizeSelect" onchange="filter('pagesize', this)">
						<option value="10" ${empty param['pagesize'] || param['pagesize'] == '10' ? 'selected' : ''}>10</option>
						<option value="25" ${param['pagesize'] == '25' ? 'selected' : ''}>25</option>
						<option value="50" ${param['pagesize'] == '50' ? 'selected' : ''}>50</option>
						<option value="100" ${param['pagesize'] == '100' ? 'selected' : ''}>100</option>
					</select>
				</div>
			</div>
			<div class="d-flex flex-column">
				<div class="form-group form-inline">
					<label for="statusSelect">Trạng thái đơn hàng</label>
					<select class="form-control ml-1" id="statusSelect" onchange="filter('status', this)">
						<option value="" ${empty param['status'] ? 'selected' : ''}>Tất cả</option>
						<option value="-1" ${param['status'] == '-1' ? 'selected' : ''}>Đã hủy</option>
						<option value="0" ${param['status'] == '0' ? 'selected' : ''}>Chờ thanh toán</option>
						<option value="1" ${param['status'] == '1' ? 'selected' : ''}>Đã thanh toán</option>
						<option value="2" ${param['status'] == '2' ? 'selected' : ''}>Đã giao hàng</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="card-body">
		<c:choose>
			<c:when test="${orders.size() > 0}">
				<c:forEach items="${orders}" var="o">
					<div class="row mb-3">
						<div class="card w-100">
							<div class="card-header">
								<div class="row">
									<div class="col">
										<h5 class="card-title">Mã đơn hàng ${o.getId()} - Ngày đặt
											<fmt:formatDate type="both" dateStyle="short" timeStyle="short"
												pattern="dd/MM/yyyy, HH:mm:ss" value="${o.getCreateTime()}" />
										</h5>
									</div>
									<div class="col-4 text-right">
										<c:choose>
											<c:when test="${o.getStatus() == 2}">
												<h5 class="card-title">Đã giao hàng</h5>
											</c:when>
											<c:when test="${o.getStatus() == 1}">
												<h5 class="card-title">Đã thanh toán</h5>
											</c:when>
											<c:when test="${o.getStatus() == 0}">
												<h5 class="card-title">Chờ thanh toán</h5>
											</c:when>
											<c:otherwise>
												<h5 class="card-title">Đã hủy</h5>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
			
							<div class="card-body">
								<c:forEach items="${o.getOrderDetails()}" var="odt" varStatus="loop">
									<c:if test="${odt.getProduct().getUser().getId() == user.getId() }">
										<div class="row">
											<div class="col">
												<div class="row">
													<div class="col-3 col-xl-2 text-center">
														<div class="img-container">
															<c:choose>
																<c:when test="${odt.getProduct().getProductImages().size() > 0 }">
																	<img src="${odt.getProduct().getProductImages().get(0).getImageLink()}">
																</c:when>
																<c:otherwise>
																	<img src='<c:url value='/templates/static/image/noproductimg.jpg'/>' width="100" height="100">
																</c:otherwise>
															</c:choose>
														</div>
													</div>
													<div class="col">
														<a href="${pageContext.request.contextPath}/productdetail?id=${odt.getProduct().getId()}">${odt.getProduct().getName()}</a>
														<br/>
														<p>x${odt.getQuantity()}</p>
													</div>
												</div>
											</div>
											<div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
												<div class="container d-flex h-100">
													<div class="row align-self-center ml-auto">
														<p><fmt:formatNumber value="${odt.getUnitPrice()}" type="currency" /></p>
													</div>
												</div>
											</div>
										</div>
										<c:if test="${!loop.last}">
											<hr class="solid">
										</c:if>
									</c:if>
								</c:forEach>
							</div>
			
							<div class="card-footer">
								<div class="row">
									<div class="col">
										<p>Tên người mua: ${o.getUser().getUsername()}</p>
										<p>Số điện thoại người mua: ${o.getUser().getPhone()}</p>
										<p>Địa chỉ giao hàng: ${o.getShipInfo().getAddress()}</p>
									</div>
									<div class="col text-right">
										<h3>Tổng tiền: <fmt:formatNumber value="${o.getTotalPrice()}" type="currency" /></h3>
										<c:if test="${o.getStatus() == 1 || o.getStatus() == 2}">
											<h6>${o.getPaymentMethod().getName()}</h6>
										</c:if>
									</div>
								</div>
								<c:if test="${o.getStatus() == 1}">
									<div class="row">
										<div class="col">
											<button class="btn btn-success float-right ml-2" onclick="deliveredOrder(${o.getId()})">Xác nhận đã giao hàng</button>
										</div>
				               		</div>
			               		</c:if>
				           </div>
				       </div>
				   </div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<h5 class="text-center">Không có dữ liệu</h5>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<div class="row mt-3 justify-content-center">
	<div class="text-center">
		<nav>
			<ul class="pagination justify-content-center">
				<c:set var="page_ref_params" value="?${not empty param['status'] ? 'status='.concat(param['status']).concat('&') : ''}${not empty param['pagesize'] ? 'pagesize='.concat(param['pagesize']).concat('&') : ''}" />

				<c:forEach items="${pages}" var="p" varStatus="loop">
					<c:choose>
						<c:when test="${p == -1}">
							<li class="page-item" style="align-self: center;">&nbsp&nbsp...&nbsp&nbsp</li>
						</c:when>
						<c:when test="${empty param['page']}">
							<c:choose>
								<c:when test="${loop.first}">
									<li class="page-item active"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${p.toString().equals(param['page'])}">
							<li class="page-item active"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</nav>
	</div>
</div>

<script type="text/javascript">	
	function deliveredOrder(idOrder){
		$.ajax({
			url: contextPath + '/api/seller/order-api',
			type: 'POST',
			data: { "type": "deliveredOrder", "idOrder": idOrder },
			dataType: "json",
			success: function (respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật trạng thái đơn hàng";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Cập nhật trạng thái đơn hàng thành công";
					$("#infoModal").modal('show');
					$('#infoModal').on('hidden.bs.modal', function () {
						 location.reload();
					});
				}
			},
			error: function (xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật trạng thái đơn hàng";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idOrder: ' + idOrder;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
</script>
