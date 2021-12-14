<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
	.my-avatar-img {
		width: 100%;
		height: 8rem;
		object-fit: fit;
	}
	hr {
	  border: 1px solid #785d5d;
	}
</style>

<div class="menu">
	<div class="sticky-top">
		<div class="d-flex flex-column ml-1 mr-1 mt-1">
			<c:choose>
           		<c:when test="${not empty user.getAvatar()}">
           			<img class="card-img-top rounded-circle" height="200" src="${user.getAvatar()}">
           		</c:when>
           		<c:otherwise>
           			<img class="card-img-top rounded-circle" src='<c:url value='/templates/static/image/noavatar.png'/>' height="200"/>
           		</c:otherwise>
           	</c:choose>
			<p class="text-center text-white">Xin chào ${user.getUsername()}</p>
			<p class="text-center text-white">Bạn là ${user.getUserRole().getName()}</p>
			<a class="btn btn-info ml-auto mr-auto" href="${pageContext.request.contextPath}/home">QUAY VỀ TRANG CHỦ</a>
			<a class="btn btn-info ml-auto mr-auto mt-3" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
		</div>
		<hr>
		<ul class="nav nav-pills flex-column mb-auto">
			<li>
				<a href="${pageContext.request.contextPath}/seller" 
				class="nav-link text-white ${pageContext.request.servletPath == '/seller' ? 'active' : ''}"><i class="fas fa-chart-line mr-2"></i>Thống kê</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/seller/products" 
				class="nav-link text-white ${pageContext.request.servletPath == '/seller/products' ? 'active' : ''}"><i class="fas fa-list-alt mr-2"></i>Quản lý sản phẩm</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/seller/orders" 
				class="nav-link text-white ${pageContext.request.servletPath == '/seller/orders' ? 'active' : ''}"><i class="fas fa-users mr-2"></i>Quản lý đơn hàng</a>
			</li>
		</ul>
	</div>
</div>