<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>Quản lý loại sản phẩm</title>

<style>
	td {
		text-align: center;
		vertical-align: middle!important;
	}
	th {
		text-align: center;
		vertical-align: middle!important;
	}
</style>

<div class="card">
	<div class="card-header">
		<div class="row">
			<div class="col">
				<h3>DANH SÁCH LOẠI SẢN PHẨM</h3>
			</div>
			<div class="d-flex flex-column">
				<button class="btn btn-success ml-auto" onclick="showCreateNewCategoryModal()"><i class="fas fa-plus mr-2"></i>Thêm loại sản phẩm mới</button>
			</div>
		</div>
	</div>
	<div class="card-body">
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th class="col-1">Mã<br>loại sản phẩm</th>
					<th class="col-*-auto">Tên<br>loại sản phẩm</th>
					<th class="col-3">Trạng thái</th>
					<th class="col-2">Số lượng sản phẩm<br>thuộc loại sản phẩm</th>
					<th class="col-1"></th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${categories.keySet().size() > 0}">
						<c:forEach items="${categories.keySet()}" var="c" varStatus="loop">
							<tr>
								<td>${c.getId()}</td>
								<td>${c.getName()}</td>
								<td><p class="mt-auto mb-auto ${c.getActive() ? '': 'text-danger' }">${c.getActive() ? 'Đang cho phép bán' : 'Đã vô hiệu hóa'}</p></td>
								<td>${categories.get(c)}</td>
								<td>
									<button class="btn btn-primary" onclick="showEditCategoryModal(${c.getId()}, '${c.getName()}', '${c.getActive()}', this)"><i class="fas fa-edit"></i></button>
									<c:if test="${categories.get(c) == 0}">
										<button class="btn btn-danger" onclick="deleteCategory(${c.getId()}, this)"><i class="fas fa-trash-alt"></i></button>
									</c:if>
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
</div>

<div class="modal" tabindex="-1" role="dialog" id="createCategoryModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Tạo loại sản phẩm mới</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" onsubmit="return false;">
					<div class="form-group">
						<label for="new_name">Tên loại sản phẩm</label>
						<input type="text" class="form-control" id="new_name" name="name">
					</div>
					<div class="form-group row">
						<div class="col text-center">
							<button type="submit" class="btn btn-primary btn-block" onclick="addCategory(this)">Thêm loại sản phẩm</button>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>

<div class="modal" tabindex="-1" role="dialog" id="updateCategoryInfoModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Cập nhật thông tin loại sản phẩm</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card">
					<div class="card-header">
						<h5><i class="far fa-address-card mr-1"></i>Thông tin loại sản phẩm</h5>
					</div>
					<div class="card-body pb-0">
						<p id="updateCategoryInfoModalId"></p>
						<p id="updateCategoryInfoModalName"></p>
						<p id="updateCategoryInfoModalActive"></p>
					</div>
				</div>
				
				<div class="card mt-2">
					<div class="card-header">
						<h5><i class="far fa-address-card mr-1"></i>Cập nhật thông tin mới</h5>
					</div>
					<div class="card-body pb-0">
						<form method="post" onsubmit="return false;">
							<div class="form-group">
								<label for="name">Tên loại sản phẩm</label>
								<input type="text" class="form-control" id="name" name="name">
							</div>
							<fieldset class="form-group">
								<div class="row">
									<legend class="col-form-label col-sm-6 pt-0">Trạng thái loại sản phẩm</legend>
									<div class="col-sm-6">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="categoryActive" id="categoryActive1" value="true" required>
											<label class="form-check-label" for="userActive1">Cho phép bán</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="categoryActive" id="categoryActive2" value="false">
											<label class="form-check-label" for="userActive2">Vô hiệu hóa</label>
										</div>
									</div>
								</div>
							</fieldset>
							<input type="hidden" id="idCategory" name="idCategory">
							<div class="form-group row">
								<div class="col text-center">
									<button type="submit" class="btn btn-primary btn-block" onclick="updateCategory(this)">Cập nhật</button>
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
	function updateCategory(btn) {
		categoryName = $(btn.closest('form')).find('#name')[0].value;
		idCategory = $(btn.closest('form')).find('#idCategory')[0].value;
		active = $("input[name=categoryActive]:checked").val();
		
		$.ajax({
			url: contextPath + '/api/admin/category-api',
			type: 'POST',
			data: { "type" : "update", "idCategory": idCategory, "categoryName": categoryName, "active" : active },
			dataType: "json",
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật loại sản phẩm";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					let rows = document.getElementsByTagName('table')[0].rows;
					for (let i = 1; i < rows.length; i++){
						if (rows[i].cells[0].innerText == idCategory){
							rows[i].cells[1].innerText = categoryName;
							rows[i].cells[2].innerHTML = active == 'true' ? "<p class='mt-auto mb-auto'>Đang cho phép bán</p>" : "<p class='mt-auto mb-auto text-danger'>Đã vô hiệu hóa</p>";
							break;
						}
					}
					$("#updateCategoryInfoModal").modal('hide');
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật loại sản phẩm";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idCategory: ' + idCategory;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function deleteCategory(idCategory, btn) {
		$.ajax({
			url: contextPath + '/api/admin/category-api',
			type: 'POST',
			data: { "type" : "delete", "idCategory": idCategory},
			dataType: "json",
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi xóa loại sản phẩm";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					let rows = document.getElementsByTagName('table')[0].rows;
					for (let i = 1; i < rows.length; i++){
						if (rows[i].cells[0].innerText == idCategory){
							rows[i].remove();
							break;
						}
					}
					$("#updateCategoryInfoModal").modal('hide');
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi xóa loại sản phẩm";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idCategory: ' + idCategory;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function addCategory(btn) {
		categoryName = $(btn.closest('form')).find('#new_name')[0].value;
		$.ajax({
			url: contextPath + '/api/admin/category-api',
			type: 'POST',
			data: { "type" : "create", "categoryName": categoryName},
			dataType: "json",
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thêm loại sản phẩm";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					location.reload();
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi thêm loại sản phẩm";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idCategory: ' + idCategory;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}

	function showEditCategoryModal(idCategory, name, active, btn){
		$("input[name=categoryActive][value=" + active + "]").prop('checked', true);
		$('#updateCategoryInfoModalId')[0].innerText = "Mã loại sản phẩm: " + name;
		$('#updateCategoryInfoModalName')[0].innerText = "Tên loại sản phẩm: " + name;
		$('#updateCategoryInfoModalActive')[0].innerText = 'Trạng thái: ' + (active == 'true' ? 'Đang cho phép bán' : 'Đã vô hiệu hóa');
		
		$('#name')[0].value = name;
		$('#idCategory')[0].value = idCategory;
		$('#updateCategoryInfoModal').modal('show')
	}
	
	function showCreateNewCategoryModal(){
		$('#createCategoryModal').modal('show')
	}
</script>