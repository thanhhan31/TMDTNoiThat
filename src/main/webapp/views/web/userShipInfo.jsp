<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>TRANG THÔNG TIN ĐỊA CHỈ GIAO HÀNG</title>

<h2>Thông tin địa chỉ giao hàng</h2>
<hr class="solid">
<div class="container">
    <div class="row">
        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                	<th class="col-*-auto">Địa chỉ giao hàng</th>
                    <th class="col-*-auto"></th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            		<c:when test="${ships.size() > 0}">
            			
	            		<c:forEach items="${ships}" var="s">
		                    <tr>
		                        <td>${s.getAddress()}</td>
		                        <td>
		                        	<button class="btn btn-danger float-right" onclick="deleteShipInfo(${s.getId()});"><i class="fas fa-trash-alt"></i></button>
									<button class="btn btn-primary float-right mr-1" onclick="showEditModal(this, ${s.getId()});"><i class="fas fa-edit"></i></button>
								</td>
		                    </tr>
		                </c:forEach>
            		</c:when>
            		<c:otherwise>
            			<td colspan="12" class="text-center">Không có dữ liệu</td>
            		</c:otherwise>
            	</c:choose>
            </tbody>
        </table>
    </div>
    <button type="button" class="btn btn-primary mt-3" onclick="showCreateModal();"><i class="fas fa-plus mr-1"></i>Thêm</button>
</div>

<div class="modal" tabindex="-1" role="dialog" id="createModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5><i class="far fa-address-card mr-1"></i>Thêm địa chỉ giao hàng</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card mt-2">
					<div class="card-body">
						<form method="post" onsubmit="return false;" id="createForm">
							<div class="form-group">
								<label for="pw">Địa chỉ giao hàng</label>
								<textarea class="form-control" rows="4" id="newAddress" name="address" required></textarea>
							</div>
							<input type="hidden" name="userChange" value="create">
							<div class="form-group row">
								<div class="col text-center">
									<button type="submit" class="btn btn-primary btn-block" onclick="createShipInfo(this);">Thêm</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>

<div class="modal" tabindex="-1" role="dialog" id="editModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5><i class="far fa-address-card mr-1"></i>Cập nhật địa chỉ giao hàng</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card mt-2">
					<div class="card-body">
						<form method="post" onsubmit="return false;" id="editForm">
							<div class="form-group">
								<label for="pw">Địa chỉ giao hàng</label>
								<textarea class="form-control" rows="4" id="address" name="address" required></textarea>
							</div>
							<input type="hidden" id="idShip" name="idShip">
							<input type="hidden" name="userChange" value="update">
							<div class="form-group row">
								<div class="col text-center">
									<button type="submit" class="btn btn-primary btn-block" onclick="updateShipInfo();">Cập nhật</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function showCreateModal(){
		$('#newAddress', '#createForm')[0].value = '';
		$('#createModal').modal('show')
	}
	
	function showEditModal(btn, idShip){
		$('#idShip', '#editForm')[0].value = idShip;
		$('#address', '#editForm')[0].value = btn.closest('tr').getElementsByTagName('td')[0].innerText;
		$('#editModal').modal('show')
	}
	
	function createShipInfo() {		
		$.ajax({
			url: contextPath + '/user/shipinfo',
			type: 'POST',
			data: $('#createForm').serialize(),
			dataType : 'json',
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thêm địa chỉ giao hàng";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					$("#editModal").modal('hide');
					
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Thêm địa chỉ giao hàng thành công";
					$("#infoModal").modal('show');
					$('#infoModal').on('hidden.bs.modal', function () {
						 location.reload();
					})
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thêm địa chỉ giao hàng";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function updateShipInfo() {
		$.ajax({
			url: contextPath + '/user/shipinfo',
			type: 'POST',
			data: $('#editForm').serialize(),
			dataType : 'json',
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật địa chỉ giao hàng";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					$("#editModal").modal('hide');
					
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Cập nhật địa chỉ giao hàng thành công";
					$("#infoModal").modal('show');
					$('#infoModal').on('hidden.bs.modal', function () {
						 location.reload();
					})
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật địa chỉ giao hàng";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function deleteShipInfo(idShip) {
		if (!confirm('Bạn có chắc chắn muốn xóa địa chỉ giao hàng này?')){
			return;
		}
		
		$.ajax({
			url: contextPath + '/user/shipinfo',
			type: 'POST',
			data: { "userChange": "delete", "idShip": idShip },
			dataType: "json",
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi xóa địa chỉ giao hàng";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Xóa địa chỉ giao hàng thành công";
					$("#infoModal").modal('show');
					$('#infoModal').on('hidden.bs.modal', function () {
						 location.reload();
					})
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi xóa địa chỉ giao hàng";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
</script>