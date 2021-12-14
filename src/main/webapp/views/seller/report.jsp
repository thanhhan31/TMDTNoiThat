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
	#reportPieChart {
	    padding-left: 0;
	    padding-right: 0;
	    margin-left: auto;
	    margin-right: auto;
	    display: block;
	    width: 800px;
	}
</style>

<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="card-deck w-100">
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nAllProducts}</h4>
					<c:choose>
						<c:when test="${nAllProducts > 0}">
							<a href="${pageContext.request.contextPath}/seller/products" class="text-white">Sản phẩm</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Sản phẩm trong cửa hàng</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-warning mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nUnavailableProducts}</h4>
					<c:choose>
						<c:when test="${nUnavailableProducts > 0}">
							<a href="${pageContext.request.contextPath}/seller/products?outOfStock=1" class="text-white">Sản phẩm hết hàng</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Sản phẩm hết hàng</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-warning mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nDisabledProducts}</h4>
					<c:choose>
						<c:when test="${nDisabledProducts > 0}">
							<a href="${pageContext.request.contextPath}/seller/products?status=0" class="text-white">Sản phẩm đã ẩn</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Sản phẩm đã ẩn</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-danger mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nBannedProducts}</h4>
					<c:choose>
						<c:when test="${nBannedProducts > 0}">
							<a href="${pageContext.request.contextPath}/seller/products?status=-1" class="text-white">Sản phẩm bị khóa</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Sản phẩm bị khóa</p>
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
					<h4 class="card-title">${nAllOrders}</h4>
					<c:choose>
						<c:when test="${nAllOrders > 0}">
							<a href="${pageContext.request.contextPath}/seller/orders" class="text-white">Tổng số lượng đơn hàng</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Tổng số lượng đơn hàng</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nPaidOrders}</h4>
					<c:choose>
						<c:when test="${nPaidOrders > 0}">
							<a href="${pageContext.request.contextPath}/seller/orders?status=1" class="text-white">Đơn chờ giao hàng</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Đơn chờ giao hàng</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-info mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nUnpaidOrders}</h4>
					<c:choose>
						<c:when test="${nPaidOrders > 0}">
							<a href="${pageContext.request.contextPath}/seller/orders?status=0" class="text-white">Đơn chờ thanh toán</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Đơn chờ thanh toán</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="card text-white bg-danger mb-3">
				<div class="card-body text-center">
					<h4 class="card-title">${nCanceledOrders}</h4>
					<c:choose>
						<c:when test="${nCanceledOrders > 0}">
							<a href="${pageContext.request.contextPath}/seller/orders?status=-1" class="text-white">Đơn hàng đã hủy</a>
						</c:when>
						<c:otherwise>
							<p class="card-text">Đơn hàng đã hủy</p>
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
					<canvas id="reportPieChart"style="width:100%;max-width:600px;height:100%;max-height:600px;"></canvas>
					<canvas id="reportChart" class="mt-4"></canvas>
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
			chartTitle = "THỐNG KÊ DOANH THU NĂM " + t[0];
			xlable = 'Tháng';
		}
		else {
			chartTitle = "THỐNG KÊ DOANH THU THÁNG " + t[1] + " NĂM " + t[0];
			xlable = 'Ngày';
		}
		
		$.getJSON(host + '/api/seller/report-api?year=' + t[0] + '&month=' + t[1], function(data) {
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