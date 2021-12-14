<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/home">
			<img src='<c:url value='/templates/static/image/brand.jpg'/>' width="50" height="50"/>
			TMĐT Nội thất
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
			aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarCollapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item ${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">
					<a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
				</li>
				<li class="nav-item dropdown ${param['category'] != null ? 'active' : ''}">
					<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
						aria-haspopup="true" aria-expanded="false">Loại sản phẩm</a>
					<div class="dropdown-menu">
						<c:forEach items="${categories}" var="c">
							<c:choose>
								<c:when
									test="${param['category'] != null && Integer.valueOf(param['category']) == c.id}">
									<a class="dropdown-item active"
										href="${pageContext.request.contextPath}/products?category=${c.id}">${c.name}</a>
								</c:when>
								<c:otherwise>
									<a class="dropdown-item"
										href="${pageContext.request.contextPath}/products?category=${c.id}">${c.name}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</li>
				<li class="nav-item ${fn:contains(pageContext.request.servletPath, 'products') && param['category'] == null ? 'active' : ''}">
					<a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
				</li>
				<c:choose>
					<c:when test="${not empty user && user.getUserRole().getName() == 'Người bán'}">
						<li class="nav-item">
							<a class="nav-link" href="${pageContext.request.contextPath}/seller">Kênh người bán</a>
						</li>
					</c:when>
					<c:when test="${not empty user && user.getUserRole().getName() == 'Admin'}">
						<li class="nav-item">
							<a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Trang quản trị hệ thống</a>
						</li>
					</c:when>
				</c:choose>
			</ul>

			<form action="${pageContext.request.contextPath}/products" class="form-inline mt-2 mt-lg-0" method="get">
				<div class="input-group">
					<input class="form-control" type="text" name="searchName" placeholder="Nhập nội dung cần tìm">
					<c:if test="${not empty param['category'] }">
						<input type="hidden" name="category" value="${param['category']}">
					</c:if>
					<div class="input-group-append">
						<button class="btn btn-outline-success" type="submit"><i class="fas fa-search"></i></button>
					</div>
				</div>
			</form>
			
			<a href="${pageContext.request.contextPath}/cart" class="btn btn-info ml-0 ml-lg-3 mt-3 mt-lg-0">
				<i class="fas fa-shopping-cart pl-0"></i>
				Giỏ hàng
				<span class="badge badge-pill badge-light" id="cartQuantity"></span>
			</a>

			<c:choose>
				<c:when test="${not empty user}">
					<a href="${pageContext.request.contextPath}/user/info" class="btn btn-success ml-0 ml-lg-3 mt-3 mt-lg-0" id="userhref"><i class="fas fa-user mr-1"></i>${user.getUsername()}</a>
					<a href="${pageContext.request.contextPath}/logout" class="btn btn-light ml-0 ml-lg-3 mt-3 mt-lg-0"><i class="fas fa-sign-out-alt mr-1"></i>Đăng xuất</a>
				</c:when>
				<c:otherwise>
					<a class="text-white ml-3" href="${pageContext.request.contextPath}/signup">Đăng ký</a>
					<a class="text-white ml-3" href="#" onclick="goLogin();">Đăng nhập</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>