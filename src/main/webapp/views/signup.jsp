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
	<div class="wrapper zero-raduis">
		<div id="formContent">
			<h2 class="my-5">ĐĂNG KÝ TÀI KHOẢN HỆ THỐNG BÁN HÀNG NỘI THẤT TRỰC TUYẾN</h2>
			<form method="post">
				<input type="text" class="zero-raduis" name="username" placeholder="Tên người dùng" required>
				<input type="email" class="zero-raduis" name="email" placeholder="Địa chỉ email" required>
				<input type="password" class="zero-raduis" name="password" placeholder="Mật khẩu" required>
				<input type="password" class="zero-raduis" name="retypepassword" placeholder="Nhập mật khẩu" required>
				<input type="tel" class="zero-raduis" name="phone" pattern="[0-9]{10}" placeholder="Số điện thoại">
				<div id="formFooter">
					<div class="row">
						<div class="col">
							<div class="form-check text-left align-checkbox">
								<input class="form-check-input" type="checkbox" id="seller" name="isSeller">
								<label class="form-check-label" for="seller">Bạn là người bán?</label>
							</div>
						</div>
						<c:if test="${not empty errorMsg}">
							<div class="col">
								<p class="text-danger">*${errorMsg}</p>
							</div>
						</c:if>
					</div>
				</div>
				<input type="submit" class="zero-raduis" value="register">
				<h2>ĐÃ CÓ TÀI KHOẢN</h2>
				<a class="custom-href" href="${pageContext.request.contextPath}/login">ĐĂNG NHẬP</a>
			</form>
			
		</div>
	</div>
</body>
</html>