<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<title>${product.getName()}</title>
<fmt:setLocale value="vi_VN" />

<link rel="stylesheet"
    href="<c:url value = "/templates/css/star.css"/>" type="text/css" />

<div class="row">
	<div class="col">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item">
					<a href="product">All category</a>
				</li>
				<li class="breadcrumb-item active">${product.getCategory().getName()}</li>
			</ol>
		</nav>
	</div>
</div>

<div class="row">
	<div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
		<div id="carousel1" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="carousel1" data-slide-to="0" class="active"></li>
				<c:if test="${product.getProductImages().size() > 1}">
					<c:forEach var="i" begin="1" end="${product.getProductImages().size() - 1}" step="1">
						<li data-target="carousel1" data-slide-to="${i}"></li>
					</c:forEach>
				</c:if>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item text-center active">
					<c:choose>
						<c:when test="${product.getProductImages().size() == 0}">
							<img class="img-fluid" style="max-height: 360px;" src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg">
						</c:when>
						<c:otherwise>
							<img class="img-fluid" style="max-height: 360px;" src="${product.getProductImages().get(0).getImageLink()}" onclick="openImageViewModal()">
						</c:otherwise>
					</c:choose>
				</div>
				
				<c:if test="${product.getProductImages().size() > 1}">
					<c:forEach var="i" begin="1" end="${product.getProductImages().size() - 1}" step="1">
						<div class="carousel-item text-center">
							<img class="img-fluid" style="max-height: 360px;" src="${product.getProductImages().get(i).getImageLink()}" onclick="openImageViewModal()">
						</div>
					</c:forEach>
				</c:if>
			</div>
			<a class="carousel-control-prev" href="#carousel1" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#carousel1" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>
	<div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6 mt-5 mt-lg-0 d-flex align-items-stretch">
		<div class="card w-100">
			<div class="card-header">
				<h5><i class="fas fa-store mr-2"></i>Shop ${product.getUser().getUsername()}</h5>
			</div>
			<div class="card-body">
				<h3 class="card-title text-center">${product.getName()}</h3>
				<div class="container">
					<div class="row">
						<div class="col-*-3">
							<div>
								<c:forEach var="i" begin="1" end="5">
									<span class="fa fa-star ${i <= bestRating ? 'schecked' : 'sunchecked' }"></span>
								</c:forEach>
							</div>
							<small class="text-muted">Đã bán ${product.getNsold()}</small>
						</div>
						<div class="col"></div>
						
						<div class="col-*-auto text-right">
							<div class="row">
								<div class="col">
									<small class="text-muted">Số lượng bình luận ${product.getComments().size()}</small>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<small class="text-muted">Số lượt xem sản phẩm ${product.getNvisit()}</small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<h1 class="font-weight-bold text-danger text-center"><fmt:formatNumber value="${product.getUnitPrice()}" type="currency" /></h1>
			<div class="mt-5" style="text-align: center">
				<ul class="list-inline">
					<li class="list-inline-item"><i class="fa fa-truck fa-2x"></i><br>Vận chuyển nhanh chóng</li>
					<li class="list-inline-item"><i class="fa fa-credit-card fa-2x"></i><br>Thanh toán an toàn</li>
					<li class="list-inline-item"><i class="fa fa-phone fa-2x"></i><br>${product.getUser().getPhone()}</li>
				</ul>
			</div>
			
			<div class="card-footer">
				<c:choose>
					<c:when test="${product.getCategory().getActive() &&  product.getActive() == 1}">
						<form class="form-inline" onsubmit="return false;">
							<div class="form-group">
								<label for="quantity">Số lượng:</label>
								<input type="number" class="form-control ml-2" id="quantity" name="quantity" min="1" max="${product.getAvailableQuantity()}" required>
								<small class="text-muted ml-3">${product.getAvailableQuantity()} sản phẩm có sẵn</small>
							</div>
							<div class="d-flex ml-auto">
								<button class="btn btn-primary" onclick="addProductCartWithInput(${product.id})">
									<i class="fas fa-shopping-cart pl-0 mr-2"></i>Add to card
								</button>
							</div>
						</form>
					</c:when>
					<c:otherwise>
						<div class="text-center">
							<c:choose>
								<c:when test="${product.getAvailableQuantity() == 0}">
									<strong class="text-danger">SẢN PHẨM ĐÃ HẾT HÀNG</strong>
								</c:when>
								<c:when test="${product.getActive() == 0}">
									<strong class="text-danger">SẢN PHẨM ĐÃ NGỪNG BÁN</strong>
								</c:when>
								<c:when test="${product.getActive() == -1}">
									<strong class="text-danger">SẢN PHẨM ĐÃ BỊ HỆ THỐNG KHÓA</strong>
								</c:when>
								<c:when test="${not product.getCategory().getActive()}">
									<strong class="text-danger">LOẠI SẢN PHẨM CỦA SẢN PHẨM NÀY ĐÃ NGỪNG BÁN</strong>
								</c:when>
							</c:choose>
						</div>
							
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
	</div>
</div>

<div class="row mt-3 mt-lg-4">
	<div class="col">
		<div class="card">
			<div class="card-header bg-info font-weight-bold">
				Mô tả sản phẩm
			</div>
			<div class="card-body">
				<p class="card-text">${product.getDescription()}</p>
			</div>
		</div>
	</div>
</div>

<div class="row mt-3">
	<div class="col">
		<div class="card">
			<div class="card-header bg-info font-weight-bold">
				Bình luận sản phẩm
			</div>
			<div class="card-body">
				<c:choose>
					<c:when test="${comments.size() == 0}">
						<h3 class="text-center">Chưa có bình luận nào</h3>
					</c:when>
					<c:otherwise>
						<c:forEach items="${comments}" var="c" varStatus="loop">
							<div class="row">
								<div class="col-1" style="padding-right: 0; padding-left: 0;"> 
									<c:choose>
					            		<c:when test="${not empty c.getUser().getAvatar()}">
					            			<img src="${c.getUser().getAvatar()}" class="img-fluid rounded-circle">
					            		</c:when>
					            		<c:otherwise>
					            			<img src="https://visitorihuelacosta.com/forum/ext/dark1/memberavatarstatus/image/avatar.png" class="img-fluid rounded-circle">
					            		</c:otherwise>
					            	</c:choose>
								</div>
								
								<div class="col">
									<small class="text-muted">
										<fmt:formatDate type="both" dateStyle="short" timeStyle="short"
											pattern="dd/MM/yyyy, HH:mm:ss" value="${c.getTime()}" />
									</small>
									<div>
										<c:forEach var="i" begin="1" end="5">
											<span class="fa fa-star ${i <= c.getRating() ? 'schecked' : 'sunchecked' }"></span>
										</c:forEach>
									</div>
									
									<p>${c.getUser().getUsername()}</p>
									<p>${c.getComment()}</p>
								</div>
							</div>
							<c:if test="${!loop.last}">
								<hr class="solid">
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

<c:if test="${product.getActive() == 1 && product.getCategory().getActive()}">
	<div class="row mt-3">
		<div class="col">
			<div class="card">
				<div class="card-header bg-info font-weight-bold">
					Thêm bình luận cho sản phẩm
				</div>
				<div class="card-body">
					<form method="post">
						<div class="row h-100 justify-content-center align-items-center">
							<div class="col-auto mt-auto mb-auto pr-0">Mức độ hài lòng</div>
							
							<div class="col pl-0">
								<div id="rating">
									<input type="radio" id="star5" name="rating" value="5"/>
								    <label class = "full" for="star5"></label>
								 
								    <input type="radio" id="star4" name="rating" value="4"/>
								    <label class = "full" for="star4"></label>
								 
								    <input type="radio" id="star3" name="rating" value="3"/>
								    <label class = "full" for="star3"></label>
								 
								    <input type="radio" id="star2" name="rating" value="2"/>
								    <label class = "full" for="star2"></label>
								 
								    <input type="radio" id="star1" name="rating" value="1"/>
								    <label class = "full" for="star1"></label>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<label for="commentField">Nhập bình luận</label>
							<textarea class="form-control" id="commentField" name="comment" rows="3" required></textarea>
						</div>
						<input type="hidden" name="idProduct" value="${product.getId()}">
						<div class="row">
							<div class="col">
									<button type="submit" class="btn btn-primary">Đăng bình luận</button>
							</div>
							<c:if test="${not empty errorMsg}">
								<div class="col text-right">
									<p class="text-danger">*${errorMsg}</p>
								</div>
							</c:if>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${product.getCategory().getActive()}">
	<div class="row mt-3">
		<div class="col">
			<div class="card">
				<div class="card-header bg-info font-weight-bold">Sản phẩm cùng danh mục</div>
				<div class="card-body">
					<c:choose>
						<c:when test="${randomProductsCategory.size() == 0}">
							<h3 class="text-center">Không có sản phẩm cùng danh mục</h3>
						</c:when>
						<c:otherwise>
							<div class="row">
								<div class="col">
									<div class="card-deck">
										<c:forEach items="${randomProductsCategory}" var="p">
											<div class="card">
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
													<a class="card-title my-product-title-truncate" href="productdetail?id=${p.id}">${p.getName()}</a>
													<p class="my-product-comment-truncate">${p.getDescription()}</p>
													<button class="btn btn-primary float-right mt-auto" onclick="addProductCart(${p.getId()},1)">
														<i class="fas fa-shopping-cart pl-0"></i> Add to card</button>
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
										</c:forEach>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</c:if>

<div class="modal fade" id="imageViewModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Hình ảnh sản phẩm</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="carousel2" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="carousel2" data-slide-to="0" class="active"></li>
						<c:if test="${product.getProductImages().size() > 1}">
							<c:forEach var="i" begin="1" end="${product.getProductImages().size() - 1}" step="1">
								<li data-target="carousel2" data-slide-to="${i}"></li>
							</c:forEach>
						</c:if>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<c:choose>
								<c:when test="${product.getProductImages().size() == 0}">
									<img class="d-block w-100" src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg">
								</c:when>
								<c:otherwise>
									<img class="d-block w-100" src="${product.getProductImages().get(0).getImageLink()}">
								</c:otherwise>
							</c:choose>
						</div>
						
						<c:if test="${product.getProductImages().size() > 1}">
							<c:forEach var="i" begin="1" end="${product.getProductImages().size() - 1}" step="1">
								<div class="carousel-item">
									<img class="d-block w-100" src="${product.getProductImages().get(i).getImageLink()}">
								</div>
							</c:forEach>
						</c:if>
					</div>
					<a class="carousel-control-prev" href="#carousel2" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#carousel2" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function openImageViewModal() {
		$('#imageViewModal').modal('show')
	}
</script>