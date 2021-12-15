<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
	hr {
	  border: 1px solid #785d5d;
	}
</style>
<div class="menu" style="display: grid;">
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
		</div>
		<hr>
		<ul class="nav nav-pills flex-column mb-auto">
			<li>
				<a href="${pageContext.request.contextPath}/admin" 
				class="nav-link text-white ${pageContext.request.servletPath == '/admin' ? 'active' : ''}"><i class="fas fa-chart-line mr-2"></i>Thống kê hệ thống</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/admin/users" 
				class="nav-link text-white ${pageContext.request.servletPath == '/admin/users' ? 'active' : ''}"><i class="fas fa-users mr-2"></i>Quản lý người dùng</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/admin/categories" 
				class="nav-link text-white ${pageContext.request.servletPath == '/admin/categories' ? 'active' : ''}"><i class="fas fa-list-alt mr-2"></i>Quản lý loại sản phẩm</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/admin/products" 
				class="nav-link text-white ${pageContext.request.servletPath == '/admin/products' ? 'active' : ''}"><i class="fas fa-cubes mr-2"></i>Quản lý sản phẩm</a>
			</li>
		</ul>
	</div>
	<div class="d-flex flex-column" style="align-self: self-end;">
		<a class="btn btn-info ml-auto mr-auto" href="${pageContext.request.contextPath}/home">QUAY VỀ TRANG CHỦ</a>
		<a class="btn btn-info ml-auto mr-auto mt-2 mb-2" href="${pageContext.request.contextPath}/logout">ĐĂNG XUẤT</a>
	</div>
</div>