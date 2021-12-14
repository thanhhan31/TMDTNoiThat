<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>TRANG THÔNG TIN NGƯỜI DÙNG</title>

<h2>Tài khoản của tôi</h2>
<form action="${pageContext.request.contextPath}/user/info" method="post" enctype="multipart/form-data">
	<div class="form-group row">
		<label for="username" class="col-sm-2 col-form-label">Tên người dùng</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="username" name="username" placeholder="Tên tài khoản"
				value="${user.getUsername()}" required>
		</div>
	</div>
	<div class="form-group row">
		<label class="col-sm-2 col-form-label">Email</label>
		<div class="col-sm-10">
			<div class="container d-flex h-100">
				<div class="row align-self-center">${user.getEmail()}</div>
			</div>
		</div>
	</div>
	<div class="form-group row">
		<label for="phone" class="col-sm-2 col-form-label">Số điện thoại</label>
		<div class="col-sm-10">
			<input type="tel" pattern="[0-9]{10}" class="form-control" id="phone" name="phone" placeholder="Số điện thoại"
				value="${user.getPhone()}" required>
		</div>
	</div>
	<div class="form-group row">
		<label for="avatar" class="col-sm-2 col-form-label">Ảnh đại diện</label>
		<div class="col-sm-10">
			<input type="file" class="form-control" id="avatar" name="avatar" onchange="previewImage(this, 'avtimg')">
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col">
				<button type="submit" class="btn btn-primary" name="userChange" value="info">Lưu thay đổi</button>
			</div>
			<c:if test="${not empty msgerror}">
				<div class="col">
					<div class="container d-flex h-100">
						<div class="row align-self-center ml-auto text-danger">
							*${msgerror}
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty msg}">
				<div class="col">
					<div class="container d-flex h-100">
						<div class="row align-self-center ml-auto text-success">
							*${msg}
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</form>
<hr class="solid">
<h2>Đổi mật khẩu</h2>
<form action="${pageContext.request.contextPath}/user/info" method="post">
	<div class="form-group row">
		<label for="oldPassword" class="col-sm-3 col-form-label">Mật khẩu cũ</label>
		<div class="col-sm-9 input-group">
			<input class="form-control" id="oldPassword" name="oldPassword" type="password" placeholder="Mật khẩu cũ">
			<div class="input-group-append">
				<span class="input-group-text">
					<a href="#" class="toggle_hide_password">
						<i class="fas fa-eye-slash" aria-hidden="true"></i>
					</a>
				</span>
			</div>
		</div>
	</div>
	<div class="form-group row">
		<label for="newPassword" class="col-sm-3 col-form-label">Mật khẩu mới</label>
		<div class="col-sm-9 input-group">
			<input class="form-control" id="newPassword" name="newPassword" type="password" placeholder="Mật khẩu mới">
			<div class="input-group-append">
				<span class="input-group-text">
					<a href="#" class="toggle_hide_password">
						<i class="fas fa-eye-slash" aria-hidden="true"></i>
					</a>
				</span>
			</div>
		</div>
	</div>
	<div class="form-group row">
		<label for="confNewPassword" class="col-sm-3 col-form-label">Nhập lại mật khẩu mới</label>
		<div class="col-sm-9 input-group">
			<input class="form-control" id="confNewPassword" name="confNewPassword" type="password" placeholder="Nhập lại mật khẩu mới">
			<div class="input-group-append">
				<span class="input-group-text">
					<a href="#" class="toggle_hide_password">
						<i class="fas fa-eye-slash" aria-hidden="true"></i>
					</a>
				</span>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col">
				<button type="submit" class="btn btn-primary" name="userChange" value="pwd">Đổi mật khẩu</button>
			</div>
			<c:if test="${not empty pwd_msgerror}">
				<div class="col">
					<div class="container d-flex h-100">
						<div class="row align-self-center ml-auto text-danger">
							*${pwd_msgerror}
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty pwd_msg}">
				<div class="col">
					<div class="container d-flex h-100">
						<div class="row align-self-center ml-auto text-success">
							*${pwd_msg}
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</form>
<hr class="solid">

<script>
	$(document).ready(function() {
	  $(".toggle_hide_password").on('click', function(e) {
	    e.preventDefault()
	    var input_group = $(this).closest('.input-group')
	    var input = input_group.find('input.form-control')
	    var icon = input_group.find('i')

	    input.attr('type', input.attr("type") === "text" ? 'password' : 'text')
	    icon.toggleClass('fa-eye-slash fa-eye')
	  })
	})
	function previewImage(inp, imgid) {
		var src = URL.createObjectURL(inp.files[0]);
		document.getElementById(imgid).src = src;
	}
</script>