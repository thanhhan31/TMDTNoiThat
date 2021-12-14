<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>ĐĂNG NHẬP</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
	<link rel="stylesheet" href="<c:url value = " /templates/css/style.css" />" type="text/css" />

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

	<link rel="stylesheet" href="<c:url value = "/templates/css/login.css" />" type="text/css" />
</head>

<body>
	<c:choose>
		<c:when test="${not empty returnUrl}">
			<c:set var="post_url" value="${pageContext.request.contextPath}/login?returnUrl=${returnUrl}" />
		</c:when>
		<c:otherwise>
			<c:set var="post_url" value="${pageContext.request.contextPath}/login" />
		</c:otherwise>
	</c:choose>
	
	<div class="wrapper zero-raduis">
		<div id="formContent">
			<h2 class="my-5">ĐĂNG NHẬP HỆ THỐNG BÁN HÀNG NỘI THẤT TRỰC TUYẾN</h2>
			<form method="post" action="${post_url}">
				<input type="email" class="zero-raduis" name="email" placeholder="Địa chỉ email">
				<input type="password" class="zero-raduis" name="password" placeholder="Mật khẩu">
				<div id="formFooter">
					<div class="row">
						<div class="col">
							<div class="form-check form-switch text-left align-checkbox">
								<input class="form-check-input" type="checkbox" id="rememberme" name="rememberMe">
								<label class="form-check-label" for="rememberme">Nhớ tài khoản</label>
							</div>
						</div>
						<div class="col pr-0">
							<a class="underlineHover" href="#">Quên mật khẩu</a>
						</div>
					</div>
					<c:if test="${not empty param['msg'] && param['msg'] == '1'}">
						<div class="row">
							<div class="col">
								<p class="text-success">*Đăng ký thành công</p>
							</div>
						</div>
					</c:if>
					<c:if test="${not empty errorMsg}">
						<div class="row">
							<div class="col">
								<p class="text-danger">*${errorMsg}</p>
							</div>
						</div>
					</c:if>
				</div>
				<input type="submit" class="zero-raduis" value="login">
				<h2>CHƯA CÓ TÀI KHOẢN</h2>
				<a class="custom-href" href="${pageContext.request.contextPath}/signup">ĐĂNG KÝ TÀI KHOẢN</a>
			</form>
		</div>
	</div>
</body>
</html>