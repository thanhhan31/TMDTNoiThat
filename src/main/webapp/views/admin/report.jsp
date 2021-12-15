<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<fmt:setLocale value="vi_VN" />

<title>Trang quản lý bán hàng</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://raw.githubusercontent.com/google/palette.js/master/palette.js"></script>

<style>
	dt { float: left; clear: left; width: 22em; font-weight: bold; }
	dd { float: left; }
</style>

<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="card-deck w-100">
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nAdminUsers}</h4>
					<c:choose>
						<c:when test="${nAdminUsers > 0}">
							<a href="${pageContext.request.contextPath}/admin/users?idRole=1" class="text-white">Quản trị viên</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Quản trị viên</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nSellerUsers}</h4>
					<c:choose>
						<c:when test="${nSellerUsers > 0}">
							<a href="${pageContext.request.contextPath}/admin/users?idRole=3" class="text-white">Người bán</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Người bán</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nNormalUsers}</h4>
					<c:choose>
						<c:when test="${nNormalUsers > 0}">
							<a href="${pageContext.request.contextPath}/admin/users?idRole=2" class="text-white">Người mua hàng</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Người mua hàng</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-danger mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nBannedUsers}</h4>
					<c:choose>
						<c:when test="${nBannedUsers > 0}">
							<a href="${pageContext.request.contextPath}/admin/users?status=0" class="text-white">Tài khoản bị khóa</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Tài khoản bị khóa</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<div class="row justify-content-center mb-3">
		<div class="card-deck w-100">
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nOrders}</h4>
					<p class="card-text">Đơn hàng trên hệ thống</p>
				</div>
			</div>
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nDeliveriedOrders}</h4>
					<p class="card-text">Đơn hàng giao thành công</p>
				</div>
			</div>
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nProducts}</h4>
					<c:choose>
						<c:when test="${nProducts > 0}">
							<a href="${pageContext.request.contextPath}/admin/products" class="text-white">Sản phẩm trên hệ thống</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Sản phẩm trên hệ thống</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-danger mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nBannedProducts}</h4>
					<c:choose>
						<c:when test="${nBannedProducts > 0}">
							<a href="${pageContext.request.contextPath}/admin/products?status=-1" class="text-white">Sản phẩm bị cấm</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Sản phẩm bị cấm</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">
					<div class="row">
						<div class="col mt-auto mb-auto">
							<h5><i class="fas fa-chart-line mr-2"></i>THỐNG KÊ DOANH THU</h5>
						</div>
						<div class="d-flex flex-column mr-3">
							<form class="form-inline">
								<div class="form-group form-inline">
									<label for="monthSelect" class="ml-2">Chọn khoảng thời gian</label>
									<select class="form-control ml-2" id="timeSelect" onchange="showReport()">
										<c:forEach items="${orderTimes.keySet()}" var="y" varStatus="loop">
											<optgroup label="Năm ${y}">
												<option value="${y},-1">Tất cả tháng năm ${y}</option>
												<c:forEach items="${orderTimes.get(y)}" var="m">
													<option value="${y},${m}">Tháng ${m} năm ${y}</option>
												</c:forEach>
											</optgroup>
										</c:forEach>
									</select>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div style="position: relative; height:45vh; width:45vw" class="mr-auto ml-auto">
						<canvas id="reportPieChart"></canvas>
					</div>
					<div>
						<canvas id="reportChart" class="mt-4"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	let c = $('#timeSelect')[0].getElementsByTagName('optgroup');
	if (c.length > 0){
		let c2 = c[c.length - 1];
		$('#timeSelect')[0].value = c2.getElementsByTagName('option')[0].value;
		$('#timeSelect')[0].onchange();
	}
	
	var myChart = null;
	var myPieChart = null;
	
	var formatter = new Intl.NumberFormat('vi-VN', {
		style: 'currency',
		currency: 'VND',
	});
	
	function showReport(){
		let host = window.location.protocol + "//" + window.location.host + contextPath;
		let t = $('#timeSelect').val().split(',');
		let chartTitle = '';
		let xlable = '';
		if (t[1] === '-1'){
			chartTitle = "THỐNG KÊ DOANH HỆ THỐNG THU NĂM " + t[0];
			xlable = 'Tháng';
		}
		else {
			chartTitle = "THỐNG KÊ DOANH THU HỆ THỐNG THÁNG " + t[1] + " NĂM " + t[0];
			xlable = 'Ngày';
		}
		
		$.getJSON(host + '/api/admin/report-api?year=' + t[0] + '&month=' + t[1], function(data) {
			randColor = [];
			let pieX = [];
			let pieY = [];
			let s = 0;
			Object.keys(data).forEach(function(key) {
				if (data[key] > 0) {
					pieX.push(xlable + key);
					pieY.push(data[key]);
					randColor.push(generateRandomColor());
					s += data[key];
				}
			});

			chartTitle += ' (' + formatter.format(s) + ')'
			
			if (myChart != null){
				myChart.destroy();
			}
			myChart = new Chart("reportChart", {
				type: 'bar',
				data: {
					labels: Object.keys(data),
					datasets: [
						{
							label: 'Tổng tiền bán hàng',
							data: Object.values(data),
							backgroundColor: randColor,
						}
					]
				},
				options: {
					plugins: { 
						legend: { 
							display: false 
						}
					},
					scales: {
						x: {
							ticks: {
								font: {
									size: 20
								}
							},
							title: {
								display: true,
								text: xlable,
								font: {
									size: 25
								}
							}
						},
						y: {
							ticks: {
								font: {
									size: 20
								}
							},
							title: {
								display: true,
								text: 'VNĐ',
								font: {
									size: 20
								}
							}
						}
					}
			    }
			});

			if (myPieChart != null){
				myPieChart.destroy();
			}
			
			myPieChart = new Chart("reportPieChart", {
				  type: "pie",
				  data: {
				    labels: pieX,
				    datasets: [{
						backgroundColor: randColor,
						data: pieY
				    }]
				  },
				  options: {
					maintainAspectRatio: false,
					plugins: {
						title: {
			                display: true,
			                text: chartTitle,
			                font: {
								size: 25
							}
			            },
					}
				  }
				});
		});
	}
</script>