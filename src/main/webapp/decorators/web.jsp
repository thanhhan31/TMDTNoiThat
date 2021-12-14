<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!doctype html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title><dec:title /></title>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	
	<script src="<c:url value="/scripts/web/web.js"/>" type="text/javascript"></script>
	<script src="<c:url value="/scripts/mylib.js"/>" type="text/javascript"></script>
	<script>var contextPath = "${pageContext.request.contextPath}"</script>
	
	<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
		crossorigin="anonymous">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
	<link rel="stylesheet"
		href="<c:url value = "/templates/css/style.css"/>" type="text/css" />
</head>
<body>
<!-- HEADER -->
	<%@ include file="/common/web/header.jsp"%>
<!-- END HEADER -->

	<div class="container mt-5 mt-sm-2 mt-lg-5 mt-xl-2" style="padding-top: 80px;" id="page-content-container">
<!-- CONTENT -->
		<dec:body />
<!-- END CONTENT -->
	</div>
	<div class="container-fluid">
<!-- FOOTER -->
		<%@ include file="/common/web/footer.jsp"%>
<!-- END FOOTER -->
	</div>
	<%@ include file="/common/modal.jsp" %>
</body>
</html>