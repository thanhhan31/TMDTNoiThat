<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>TRANG SẢN PHẨM</title>

<fmt:setLocale value="vi_VN" />

<div class="row">
	<div class="col-12 col-sm-3 col-md-3 col-lg-3 col-xl-3">
		<div class="row">
			<div class="col">
				<div class="card">
					<div class="card-header bg-success"><i class="fa fa-list mr-1"></i>Loại sản phẩm</div>
					<ul class="list-group">
						<c:forEach items="${categoriesQty.keySet()}" var="c">
							<li class="list-group-item d-flex justify-content-between align-items-center list-group-item-action ${param['category'] != null && c.id == Integer.parseInt(param['category']) ? 'active' : ''}">
								<c:choose>
									<c:when test="${not empty param['sort']}">
										<a class="text-dark" href="products?category=${c.id}&sort=${param['sort']}">${c.name}</a>
									</c:when>
									<c:otherwise>
										<a class="text-dark" href="products?category=${c.id}">${c.name}</a>
									</c:otherwise>
								</c:choose>
								<span class="badge badge-secondary badge-pill">${categoriesQty.get(c)}</span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col">
				<div class="card">
					<div class="card-header bg-success"><i class="fa fa-list mr-1"></i>Sản phẩm mới nhất</div>
					<div class="card-body">
						<div class="row">
							<c:forEach items="${lastedProducts}" var="p" varStatus="loop">
								<div class="col pl-0 pr-0 ${loop.last ? '' : 'mb-3' }">
									<div class="card">
										<c:choose>
											<c:when test="${p.getProductImages().size() == 0}">
												<img class="my-card-img-top" src='<c:url value='/templates/static/image/noproductimg.jpg'/>'>
											</c:when>
											<c:otherwise>
												<img class="my-card-img-top" src="${p.getProductImages().get(0).getImageLink()}" />
											</c:otherwise>
										</c:choose>
				
										<div class="card-body d-flex flex-column">
											<a class="card-title my-product-title-truncate" href="productdetail?id=${p.id}">${p.getName()}</a>
											<p class="my-product-comment-truncate">${p.getDescription()}</p>
											<button class="btn btn-primary float-right mt-auto" onclick="addProductCart(${p.getId()},1)">
												<i class="fas fa-shopping-cart pl-0 mr-2"></i>Thêm vào giỏ hàng</button>
										</div>
				
										<div class="card-footer">
											<div class="row">
												<div class="col-sm">
													<small class="text-secondary text-danger font-weight-bold">
														<fmt:formatNumber value="${p.getUnitPrice()}" type="currency" />
													</small>
												</div>
												<div class="col-sm text-right text-muted">
													<small>Đã bán ${p.nsold}</small>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-12 col-sm-9 col-md-9 col-lg-9 col-xl-9">
		<div class="row">
			<div class="col pl-auto pr-auto mt-3 mt-sm-auto pr-md-0 pl-md-0">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
						<li class="breadcrumb-item">
							<a href="${pageContext.request.contextPath}/products">All category</a>
						</li>
						<c:if test="${not empty selectedCategory}">
							<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?category=${param['category']}">${selectedCategory}</a></li>
						</c:if>
						
						<c:if test="${not empty param['searchName']}">
							<li class="breadcrumb-item active">Kết quả tìm kiếm '${param['searchName']}' (${productCount} kết quả)</li>
						</c:if>
						
						<c:choose>
							<c:when test="${param['page'] == null}">
								<li class="breadcrumb-item active">Trang 1</li>
							</c:when>
							<c:otherwise>
								<li class="breadcrumb-item active">Trang ${param['page'] + 1}</li>
							</c:otherwise>
						</c:choose>
					</ol>
				</nav>
			</div>
		</div>
		<div class="row" style="justify-content: right;">
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
			<div class="d-flex flex-column mr-3">
				<div class="form-group form-inline">
					<label for="sortSelect">Sắp xếp</label>
					<select class="form-control ml-1" id="sortSelect" onchange="filter('sort', this)">
						<option value="" ${empty param['sort'] ? 'selected' : ''}>Mặc định</option>
						<option value="1" ${param['sort'] == '1' ? 'selected' : ''}>Giá giảm dần</option>
						<option value="2" ${param['sort'] == '2' ? 'selected' : ''}>Giá tăng dần</option>
						<option value="3" ${param['sort'] == '3' ? 'selected' : ''}>Bán chạy</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row">
			<c:choose>
				<c:when test="${products.size() > 0}">
					<c:forEach items="${products}" var="p">
						<div class="col-12 col-sm-12 col-md-6 col-lg-4 col-xl-4 mb-2">
							<div class="card w-100 h-100">
								<c:choose>
									<c:when test="${p.getProductImages().size() == 0}">
										<img class="my-card-img-top"
											src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg" />
									</c:when>
									<c:otherwise>
										<img class="my-card-img-top" src="${p.getProductImages().get(0).getImageLink()}" />
									</c:otherwise>
								</c:choose>
		
								<div class="card-body d-flex flex-column">
									<div class="eight-line-container">
										<a class="card-title my-product-title-truncate" href="${pageContext.request.contextPath}/productdetail?id=${p.id}">${p.getName()}</a>
										<p class="my-product-comment-truncate">${p.getDescription()}</p>
									</div>
									<button class="btn btn-primary float-right mt-auto" onclick="addProductCart(${p.getId()},1)">
										<i class="fas fa-shopping-cart pl-0 mr-2"></i>Thêm vào giỏ hàng</button>
								</div>
		
								<div class="card-footer">
									<div class="row">
										<div class="col-sm">
											<small class="text-secondary text-danger font-weight-bold">
												<fmt:formatNumber value="${p.getUnitPrice()}" type="currency" />
											</small>
										</div>
										<div class="col-sm text-right text-muted">
											<small>Đã bán ${p.nsold}</small>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="col">
						<h3 class="text-center mt-4">Không có sản phẩm nào</h3>
					</div>
					
				</c:otherwise>
			</c:choose>
		</div>
		<br>
		<br>
		<div class="row justify-content-center">
			<div class="text-center">
				<nav>
					<ul class="pagination justify-content-center">
						<c:set var="page_ref_params" value="?${not empty selectedCategory ? 'category='.concat(param['category']).concat('&') : ''}${not empty param['searchName'] ? 'searchName='.concat(param['searchName']).concat('&') : ''}${not empty param['sort'] ? 'sort='.concat(param['sort']).concat('&') : ''}${not empty param['pagesize'] ? 'pagesize='.concat(param['pagesize']).concat('&') : ''}" />

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
	</div>
</div>