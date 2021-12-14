<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<fmt:setLocale value="vi_VN" />

<title>Sản phẩm</title>

<style>
	.product-image{
		width: 100%;
		height: 7rem;
		object-fit: fit;
	}
	.my-text-truncate {
		display: -webkit-box;
		-webkit-line-clamp: 4;
		-webkit-box-orient: vertical;
		overflow: hidden;
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

<div class="card">
	<div class="card-header">
		<div class="row">
			<div class="col">
				<div class="row">
					<div class="col">
						<h3>DANH SÁCH SẢN PHẨM</h3>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<form method="post">
							<button type="submit" class="btn btn-success ml-auto" name="type" value="create"><i class="fas fa-plus mr-2"></i>Tạo sản phẩm mới</button>
						</form>
					</div>
				</div>
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
				<div class="form-group form-inline">
					<label for="stockSelect">Số lượng</label>
					<select class="form-control ml-1" id="stockSelect" onchange="filter('outOfStock', this)">
						<option value="" ${empty param['outOfStock'] ? 'selected' : ''}>Tất cả</option>
						<option value="0" ${param['outOfStock'] == '0' ? 'selected' : ''}>Còn hàng</option>
						<option value="1" ${param['outOfStock'] == '1' ? 'selected' : ''}>Hết hàng</option>
					</select>
				</div>
			</div>
			<div class="d-flex flex-column mr-3">
				<div class="form-group form-inline">
					<label for="statusSelect">Trạng thái</label>
					<select class="form-control ml-1" id="statusSelect" onchange="filter('status', this)">
						<option value="" ${empty param['status'] ? 'selected' : ''}>Tất cả</option>
						<option value="-1" ${param['status'] == '-1' ? 'selected' : ''}>Đã vô hiệu hóa bởi quản trị viên</option>
						<option value="0" ${param['status'] == '0' ? 'selected' : ''}>Đã vô hiệu hóa</option>
						<option value="1" ${param['status'] == '1' ? 'selected' : ''}>Đang kích hoạt</option>
					</select>
				</div>
				<div class="form-group form-inline">
					<label for="categorySelect">Loại sản phẩm</label>
					<select class="form-control ml-1" id="categorySelect" onchange="filter('category', this)">
						<option value="" ${empty param['category'] ? 'selected' : ''}>Tất cả</option>
						<c:forEach items="${categoriesQty.keySet()}" var="c">
							<option value="${c.getId()}" ${c.getId().toString().equals(param['category']) ? 'selected' : ''}>${c.getName()} (${categoriesQty.get(c)})</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="card-body">
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th class="col-*-auto">#</th>
					<th class="col-*-auto"></th>
					<th class="col-*-auto">Mã sản phẩm</th>
					<th class="col-*-auto">Loại sản phẩm</th>
					<th class="col-*-auto">Tên sản phẩm</th>
					<th class="col-*-auto">Giá bán</th>
					<th class="col-3">Mô tả</th>
					<th class="col-*-auto">Thời gian tạo</th>
					<th class="col-*-auto">Số lượt xem</th>
					<th class="col-*-auto">Số lượng bình luận</th>
					<th class="col-*-auto">Số lượng bán được</th>
					<th class="col-*-auto">Trạng thái</th>
					<th class="col-*-auto">Số lượng hiện có</th>
					<th class="col-*-auto"></th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${products.size() > 0}">
						<c:forEach items="${products}" var="p" varStatus="loop">
							<tr>
								<td>${loop.index + 1 + currentPage * pagesize}</td>
								<td>
									<div class="d-flex justify-content-center" style="align-self: center;">
										<div class="row h-100">
											<c:choose>
												<c:when test="${p.getProductImages().size() > 0 }">
													<img class="product-image" src="${p.getProductImages().get(0).getImageLink()}">
												</c:when>
												<c:otherwise>
													<img class="product-image" src='<c:url value='/templates/static/image/noproductimg.jpg'/>'/>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</td>
								<td>${p.getId()}</td>
								<td>${p.getCategory().getName()}</td>
								<td><a href="${pageContext.request.contextPath}/productdetail?id=${p.getId()}" target="_blank">${p.getName()}</a></td>
								<td><fmt:formatNumber value="${p.getUnitPrice()}" type="currency" /></td>
								<td><p class="my-text-truncate" style="text-align: left;">${p.getDescription()}</p></td>
								<td><fmt:formatDate type="both" dateStyle="short" timeStyle="short" pattern="dd/MM/yyyy, HH:mm:ss" value="${p.getCreateTime()}"/></td>
								<td>${p.getNvisit()}</td>
								<td>${p.getComments().size()}</td>
								<td>${p.getNsold()}</td>
								<td>
									<c:choose>
										<c:when test="${not p.getCategory().getActive()}">Loại sản phẩm đã vô hiệu hóa</c:when>
										<c:when test="${p.getActive() == 1}">Đang hoạt động</c:when>
										<c:when test="${p.getActive() == 0}">Đã vô hiệu hóa</c:when>
										<c:otherwise>Đã vô hiệu hóa bởi quản trị viên</c:otherwise>
									</c:choose>
								</td>
								<td>${p.getAvailableQuantity()}</td>
								<td>
									<form method="post">
										<input type="hidden" name="idProduct" value="${p.getId()}">
										<button class="btn btn-primary" name="type" value="update"><i class="fas fa-edit"></i></button>
									</form>
									<c:choose>
										<c:when test="${p.getActive() == 1}">
											<button class="btn btn-danger" onclick="setProductActive(${p.getId()}, 0)"><i class="fas fa-eye-slash"></i></button>
										</c:when>
										<c:when test="${p.getActive() == 0}">
											<button class="btn btn-success" onclick="setProductActive(${p.getId()}, 1)"><i class="fas fa-eye"></i></button>
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<td colspan="13" class="text-center">Không có dữ liệu</td>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>
<div class="row justify-content-center">
	<div class="text-center">
		<nav>
			<ul class="pagination justify-content-center">
				<c:set var="page_ref_params" value="?${not empty param['category'] ? 'category='.concat(param['category']).concat('&') : ''}${not empty param['status'] ? 'status='.concat(param['status']).concat('&') : ''}${not empty param['pagesize'] ? 'pagesize='.concat(param['pagesize']).concat('&') : ''}" />

				<c:forEach items="${pages}" var="p" varStatus="loop">
					<c:choose>
						<c:when test="${p == -1}">
							<li class="page-item">&nbsp&nbsp...&nbsp&nbsp</li>
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


<script>
	function setProductActive(idProduct, active) {
		let type = '';
		if (active == 1){
			type = 'enable';
		}
		else {
			type = 'disable';
		}
			
		$.ajax({
			url: contextPath + '/api/seller/product-api',
			type: 'POST',
			data: { "type": type, "idProduct": idProduct },
			dataType: "json",
			success: function(respone) {
				if (respone.status !== "200") {
					if (active == 1){
						$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi kích hoạt sản phẩm";
					}
					else {
						$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi vô hiệu hóa sản phẩm";
					}
					
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					window.location.reload();
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					if (active == 1){
						$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi kích hoạt sản phẩm";
					}
					else {
						$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi vô hiệu hóa sản phẩm";
					}
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
</script>