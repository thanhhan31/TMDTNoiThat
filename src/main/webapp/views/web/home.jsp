<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>TRANG THƯƠNG MẠI ĐIỆN TỬ ĐỒ NỘI THẤT</title>
<fmt:setLocale value="vi_VN" />

<div class="row">
	<div class="col">
		<div class="card">
			<div class="card-header">
				<h4><i class="fas fa-star"></i> Sản phẩm bán chạy nhất</h4>
			</div>
			<div class="card-body">
				<div id="topSoldCarousel" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<c:forEach var="i" begin="0" end="${nTopPage - 1}">
							<li data-target="#topSoldCarousel" data-slide-to="${i}"  ${i == 0 ? 'class="active"' : '' }></li>
						</c:forEach>					
					</ol>
					<div class="carousel-inner">
						<c:forEach var="i" begin="0" end="${nTopPage - 1}">
							<div class="carousel-item ${i == 0 ? 'active' : ''}">
								<div class="row">
									<div class="col">
										<div class="card-deck">
											<c:forEach var="j" begin="${i * nProductPerTopPage}" end="${(i + 1) * nProductPerTopPage - 1}">
												<div class="card">
													<c:choose>
														<c:when test="${topSoldProducts.get(j).getProductImages().size() == 0}">
															<img class="my-card-img-top" src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg"/>
														</c:when>
														<c:otherwise>
															<img class="my-card-img-top" src="${topSoldProducts.get(j).getProductImages().get(0).imageLink}"/>
														</c:otherwise>
													</c:choose>
												
													<div class="card-body d-flex flex-column">
														<div class="eight-line-container">
															<a class="card-title my-product-title-truncate" href="productdetail?id=${topSoldProducts.get(j).getId()}">${topSoldProducts.get(j).getName()}</a>
															<p class="my-product-comment-truncate">${topSoldProducts.get(j).getDescription()}</p>
														</div>
														<button class="btn btn-primary float-right mt-auto" onClick="addProductCart(${topSoldProducts.get(j).getId()},1)">
															<i class="fas fa-shopping-cart pl-0 mr-2"></i>Thêm vào giỏ hàng
														</button>
													</div>
												
													<div class="card-footer">
														<div class="row">
															<div class="col">
																<small class="text-secondary text-danger font-weight-bold">
																	<fmt:formatNumber value="${topSoldProducts.get(j).getUnitPrice()}" type="currency" />
																</small>
															</div>
															<div class="col text-right text-muted">
																<small>Đã bán ${topSoldProducts.get(j).getNsold()}</small>
															</div>
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<a class="carousel-control-prev" href="#topSoldCarousel" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#topSoldCarousel" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row mt-3">
	<div class="col">
		<div class="card">
			<div class="card-header">
				<h4><i class="fas fa-eye"></i> Sản phẩm có lượt xem nhiều nhất</h4>
			</div>
			<div class="card-body">
				<div id="topViewCarousel" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<c:forEach var="i" begin="0" end="${nTopPage - 1}">
							<li data-target="#topViewCarousel" data-slide-to="${i}"  ${i == 0 ? 'class="active"' : '' }></li>
						</c:forEach>					
					</ol>
					<div class="carousel-inner">
						<c:forEach var="i" begin="0" end="${nTopPage - 1}">
							<div class="carousel-item ${i == 0 ? 'active' : ''}">
								<div class="row">
									<div class="col">
										<div class="card-deck">
											<c:forEach var="j" begin="${i * nProductPerTopPage}" end="${(i + 1) * nProductPerTopPage - 1}">
												<div class="card">
													<c:choose>
														<c:when test="${topViewProducts.get(j).getProductImages().size() == 0}">
															<img class="my-card-img-top" src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg"/>
														</c:when>
														<c:otherwise>
															<img class="my-card-img-top" src="${topViewProducts.get(j).getProductImages().get(0).imageLink}"/>
														</c:otherwise>
													</c:choose>
												
													<div class="card-body d-flex flex-column">
														<div class="eight-line-container">
															<a class="card-title my-product-title-truncate" href="productdetail?id=${topViewProducts.get(j).getId()}">${topViewProducts.get(j).getName()}</a>
															<p class="my-product-comment-truncate">${topViewProducts.get(j).getDescription()}</p>
														</div>
														<button class="btn btn-primary float-right mt-auto" onClick="addProductCart(${topViewProducts.get(j).getId()},1)">
															<i class="fas fa-shopping-cart pl-0 mr-2"></i>Thêm vào giỏ hàng
														</button>
													</div>
												
													<div class="card-footer">
														<div class="row">
															<div class="col">
																<small class="text-secondary text-danger font-weight-bold">
																	<fmt:formatNumber value="${topViewProducts.get(j).getUnitPrice()}" type="currency" />
																</small>
															</div>
															<div class="col text-right text-muted">
																<small>${topViewProducts.get(j).getNvisit()} lượt xem</small>
															</div>
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<a class="carousel-control-prev" href="#topViewCarousel" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#topViewCarousel" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				
			</div>
		</div>
	</div>
</div>

<div class="row mt-3">
	<div class="col">
		<div class="card">
			<div class="card-header">
				<h4><i class="fas fa-comments"></i> Sản phẩm có nhiều bình luận</h4>
			</div>
			<div class="card-body">
				<div id="topCommentCarousel" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<c:forEach var="i" begin="0" end="${nTopPage - 1}">
							<li data-target="#topCommentCarousel" data-slide-to="${i}"  ${i == 0 ? 'class="active"' : '' }></li>
						</c:forEach>					
					</ol>
					<div class="carousel-inner">
						<c:forEach var="i" begin="0" end="${nTopPage - 1}">
							<div class="carousel-item ${i == 0 ? 'active' : ''}">
								<div class="row">
									<div class="col">
										<div class="card-deck">
											<c:forEach var="j" begin="${i * nProductPerTopPage}" end="${(i + 1) * nProductPerTopPage - 1}">
												<div class="card">
													<c:choose>
														<c:when test="${topCommentProducts.get(j).getProductImages().size() == 0}">
															<img class="my-card-img-top" src="https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg"/>
														</c:when>
														<c:otherwise>
															<img class="my-card-img-top" src="${topCommentProducts.get(j).getProductImages().get(0).imageLink}"/>
														</c:otherwise>
													</c:choose>
												
													<div class="card-body d-flex flex-column">
														<div class="eight-line-container">
															<a class="card-title my-product-title-truncate" href="productdetail?id=${topCommentProducts.get(j).getId()}">${topCommentProducts.get(j).getName()}</a>
															<p class="my-product-comment-truncate">${topCommentProducts.get(j).getDescription()}</p>
														</div>
														<button class="btn btn-primary float-right mt-auto" onClick="addProductCart(${topCommentProducts.get(j).getId()},1)">
															<i class="fas fa-shopping-cart pl-0 mr-2"></i>Thêm vào giỏ hàng
														</button>
													</div>
												
													<div class="card-footer">
														<div class="row">
															<div class="col">
																<small class="text-secondary text-danger font-weight-bold">
																	<fmt:formatNumber value="${topCommentProducts.get(j).getUnitPrice()}" type="currency" />
																</small>
															</div>
															<div class="col text-right text-muted">
																<small>${topCommentProducts.get(j).getComments().size()} bình luận</small>
															</div>
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<a class="carousel-control-prev" href="#topCommentCarousel" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#topCommentCarousel" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				
			</div>
		</div>
	</div>
</div>