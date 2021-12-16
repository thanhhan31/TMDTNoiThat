<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<title>Quản lý người dùng</title>

<style>
	.avt-img {
		width: 100%;
		height: 7rem;
		object-fit: fit;
	}
	td {
		text-align: center;
		vertical-align: middle!important;
	}
	th {
		text-align: center;
		vertical-align: middle!important;
	}
	.cell-text-truncate {
		white-space: nowrap; 
		text-overflow:ellipsis; 
		overflow: hidden; 
		max-width:1px;
	}
</style>

<div class="card">
	<div class="card-header pb-0">
		<div class="row">
			<div class="col">
				<div class="row">
					<div class="col">
						<h3>DANH SÁCH TÀI KHOẢN</h3>
					</div>
				</div>
				<div class="row mb-2">
					<div class="col">
						<button class="btn btn-success ml-auto" onclick="showCreateNewUserModal()"><i class="fas fa-plus mr-2"></i>Tạo tài khoản mới</button>
					</div>
				</div>
			</div>
			<div class="d-flex flex-column mr-3">
				<form class="form-inline mt-2 mt-lg-0" onsubmit="return false;">
					<div class="input-group">
						<input class="form-control" type="text" id="searchName" name="searchName" placeholder="Nhập tên người dùng cần tìm" value="${empty param['searchName'] ? '' :  param['searchName']}">
						<div class="input-group-append">
							<button class="btn btn-success" type="submit" onclick="searchUser(this)"><i class="fas fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>
			<div class="d-flex flex-column mr-3">
				<div class="form-group form-inline">
					<label for="paginateSizeSelect">Hiển thị</label>
					<select class="form-control ml-1" id="paginateSizeSelect" onchange="filter('pagesize', this)">
						<option value="10" ${empty param['pagesize'] || param['pagesize'] == '10' ? 'selected' : ''}>10</option>
						<option value="25" ${param['pagesize'] == '25' ? 'selected' : ''}>25</option>
						<option value="50" ${param['pagesize'] == '50' ? 'selected' : ''}>50</option>
						<option value="100" ${param['pagesize'] == '100' ? 'selected' : ''}>100</option>
					</select>
				</div>
			</div>
			<div class="d-flex flex-column mr-3">
				<div class="form-group form-inline">
					<label for="statusSelect">Trạng thái</label>
					<select class="form-control ml-1" id="statusSelect" onchange="filter('status', this)">
						<option value="" ${empty param['status'] ? 'selected' : ''}>Tất cả</option>
						<option value="1" ${param['status'] == '1' ? 'selected' : ''}>Đang hoạt động</option>
						<option value="0" ${param['status'] == '0' ? 'selected' : ''}>Đã vô hiệu hóa</option>
					</select>
				</div>
				<div class="form-group form-inline">
					<label for="statusSelect">Chức vụ</label>
					<select class="form-control ml-1" id="statusSelect" onchange="filter('idRole', this)">
						<option value="" ${empty param['idRole'] ? 'selected' : ''}>Tất cả</option>
						<c:forEach items="${userRoleQty.keySet()}" var="ur">
							<option value="${ur.getId()}" ${ur.getId().toString().equals(param['idRole']) ? 'selected' : ''}>${ur.getName()} (${userRoleQty.get(ur)})</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="card-body">
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th class="col-*-auto"></th>
					<th class="col-*-auto pl-0 pr-0">Mã<br>tài khoản</th>
					<th class="col-*-auto">Tên tài khoản</th>
					<th class="col-*-auto">Chức vụ</th>
					<th class="col-*-auto">Email</th>
					<th class="col-*-auto">Số điện thoại</th>
					<th class="col-*-auto">Thời gian tạo</th>
					<th class="col-*-auto">Trạng thái</th>
					<th class="col-*-auto"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="u">
					<tr>
						<td>
							<div class="d-flex justify-content-center" style="align-self: center;">
								<div class="row h-100">
									<c:choose>
					            		<c:when test="${not empty u.getAvatar()}">
					            			<img class="avt-img rounded-circle" src="${u.getAvatar()}" style="max-width:115px;">
					            		</c:when>
					            		<c:otherwise>
					            			<img class="avt-img rounded-circle" src="<c:url value='/templates/static/image/noavatar.png' />">
					            		</c:otherwise>
					            	</c:choose>
								</div>
							</div>
						</td>
						<td>${u.getId()}</td>
						<td class="cell-text-truncate">${u.getUsername()}</td>
						<td>${u.getUserRole().getName()}</td>
						<td>${u.getEmail()}</td>
						<td>${u.getPhone()}</td>
						<td><fmt:formatDate type="both" dateStyle="short" timeStyle="short" pattern="dd/MM/yyyy, HH:mm:ss" value="${u.getRegisterTime()}"/></td>
						<td>${u.getActive() ? 'Đang hoạt động' : 'Đã vô hiệu hóa'}</td>
						
						<td>
							<button class="btn btn-primary" 
								onclick="showEditUserModal(${u.getId()}, ${u.getUserRole().getId()}, '${u.getUsername()}', '${u.getPhone()}', '${u.getEmail()}', ${u.getActive()})">
								<i class="fas fa-edit"></i>
							</button>
							<button class="btn btn-primary" 
								onclick="showResetPwModal(${u.getId()})">
								<i class="fas fa-key"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<div class="row mt-3 justify-content-center">
	<div class="text-center">
		<nav>
			<ul class="pagination justify-content-center">
				<c:set var="page_ref_params" value="?${not empty param['idRole'] ? 'idRole='.concat(param['idRole']).concat('&') : ''}${not empty param['status'] ? 'status='.concat(param['status']).concat('&') : ''}${not empty param['pagesize'] ? 'pagesize='.concat(param['pagesize']).concat('&') : ''}${not empty param['searchName'] ? 'searchName='.concat(param['searchName']).concat('&') : ''}" />
				<c:forEach items="${pages}" var="p" varStatus="loop">
					<c:choose>
						<c:when test="${p == -1}">
							<li class="page-item" style="align-self: center;">&nbsp&nbsp...&nbsp&nbsp</li>
						</c:when>
						<c:when test="${empty param['page']}">
							<c:choose>
								<c:when test="${loop.first}">
									<li class="page-item active"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${p == currentPage}">
							<li class="page-item active"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${page_ref_params}page=${p}">${p + 1}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</nav>
	</div>
</div>

<div class="modal" tabindex="-1" role="dialog" id="createNewUserInfoModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5><i class="far fa-address-card mr-1"></i>Tạo tài khoản người dùng mới</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card mt-2">
					<div class="card-body">
						<form method="post" onsubmit="return false;" enctype="multipart/form-data" id="createNewUserInfoForm">
							<div class="form-group">
								<label for="new_email">Địa chỉ email</label>
								<input type="email" class="form-control" id="new_email" name="email">
							</div>
							<div class="form-group">
								<label for="password">Mật khẩu mới</label>
								<input type="password" class="form-control" id="password" name="password">
							</div>
							<div class="form-group">
								<label for="new_phone">Số điện thoại</label>
								<input type="tel" class="form-control" id="new_phone" name="phone" pattern="[0-9]{10}">
							</div>
							<div class="form-group">
								<label for="new_username">Tên người dùng</label>
								<input type="text" class="form-control" id="new_username" name="username">
							</div>
							<div class="form-group">
								<label for="new_avatar">Hình đại diện</label>
								<input type="file" class="form-control" id="new_avatar" name="avatar" accept="image/*">
							</div>
							<fieldset class="form-group">
								<div class="row">
									<legend class="col-form-label col-sm-3 pt-0">Chức vụ</legend>
									<div class="col-sm-9">
										<c:forEach items="${userRoles}" var="ur">
											<div class="form-check">
												<input class="form-check-input" type="radio" name="idRole" id="new_userRole${ur.getId()}" data-name="${ur.getName()}" value="${ur.getId()}" required>
												<label class="form-check-label" for="new_userRole${ur.getId()}">${ur.getName()}</label>
											</div>
										</c:forEach>
									</div>
								</div>
							</fieldset>
							<fieldset class="form-group">
								<div class="row">
									<legend class="col-form-label col-sm-3 pt-0">Trạng thái tài khoản</legend>
									<div class="col-sm-9">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="active" id="new_userActive1" value="true" checked>
											<label class="form-check-label" for="new_userActive1">Hoạt động</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="active" id="new_userActive2" value="false">
											<label class="form-check-label" for="new_userActive2">Vô hiệu hóa</label>
										</div>
									</div>
								</div>
							</fieldset>
							<input type="hidden" name="type" value="create">
							<div class="form-group row">
								<div class="col text-center">
									<button type="submit" class="btn btn-primary btn-block" onclick="createUser(this)">Tạo tài khoản</button>
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

<div class="modal" tabindex="-1" role="dialog" id="updateUserInfoModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="updateUserInfoModalTitle"><i class="far fa-address-card mr-1"></i></h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card mt-2">
					<div class="card-body">
						<form method="post" onsubmit="return false;" enctype="multipart/form-data" id="updateUserInfoForm">
							<div class="form-group">
								<label for="email">Địa chỉ email</label>
								<input type="email" class="form-control" id="email" name="email">
							</div>
							<div class="form-group">
								<label for="phone">Số điện thoại</label>
								<input type="tel" class="form-control" id="phone" name="phone" pattern="[0-9]{10}">
							</div>
							<div class="form-group">
								<label for="username">Tên người dùng</label>
								<input type="text" class="form-control" id="username" name="username">
							</div>
							<div class="form-group">
								<label for="avatar">Hình đại diện</label>
								<input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
							</div>
							<fieldset class="form-group">
								<div class="row">
									<legend class="col-form-label col-sm-3 pt-0">Chức vụ</legend>
									<div class="col-sm-9">
										<c:forEach items="${userRoles}" var="ur">
											<div class="form-check">
												<input class="form-check-input" type="radio" name="idRole" id="userRole${ur.getId()}" data-name="${ur.getName()}" value="${ur.getId()}" required>
												<label class="form-check-label" for="userRole${ur.getId()}">${ur.getName()}</label>
											</div>
										</c:forEach>
									</div>
								</div>
							</fieldset>
							<fieldset class="form-group">
								<div class="row">
									<legend class="col-form-label col-sm-3 pt-0">Trạng thái tài khoản</legend>
									<div class="col-sm-9">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="active" id="userActive1" value="true">
											<label class="form-check-label" for="userActive1">Hoạt động</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="active" id="userActive2" value="false">
											<label class="form-check-label" for="userActive2">Vô hiệu hóa</label>
										</div>
									</div>
								</div>
							</fieldset>
							<input type="hidden" id="idUserUpdateForm" name="idUser">
							<input type="hidden" name="type" value="update">
							<div class="form-group row">
								<div class="col text-center">
									<button type="submit" class="btn btn-primary btn-block" onclick="updateUser(this)">Cập nhật</button>
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

<div class="modal" tabindex="-1" role="dialog" id="resetPwModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="resetPwModalTitle"><i class="fas fa-key mr-1"></i></h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card mt-2">
					<div class="card-body">
						<form method="post" onsubmit="return false;" id="resetPwForm">
							<div class="form-group">
								<label for="pw">Mật khẩu mới</label>
								<input type="password" class="form-control" id="pw" name="password">
							</div>
							<div class="form-group">
								<label for="retypepw">Nhập lại mật khẩu</label>
								<input type="password" class="form-control" id="retypepw" name="repassword">
							</div>
							<input type="hidden" id="idUserResetForm" name="idUser">
							<input type="hidden" name="type" value="resetpw">
							<div class="form-group row">
								<div class="col text-center">
									<button type="submit" class="btn btn-primary btn-block" onclick="resetPw(this)">Đặt lại mật khẩu</button>
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
	function searchUser(btn) {
		searchName = $(btn.closest('form')).find('#searchName')[0].value;
		filterSearch('searchName', searchName);
	}
	
	function updateUser(btn) {
		idUser = $(btn.closest('form')).find('#idUserUpdateForm')[0].value;
		email = $(btn.closest('form')).find('#email')[0].value;
		phone = $(btn.closest('form')).find('#phone')[0].value;
		username = $(btn.closest('form')).find('#username')[0].value;
		idRole = $("input[name=idRole]:checked", '#updateUserInfoForm').val();
		roleName = $("input[name=idRole]:checked", '#updateUserInfoForm').data('name');
		active = $("input[name=active]:checked", '#updateUserInfoForm').val();
		
		var formdata = new FormData($("#updateUserInfoForm")[0]);
		
		$.ajax({
			url: contextPath + '/api/admin/user-api',
			type: 'POST',
			data: formdata,
			cache: false,
			contentType: false,
            processData: false,
			success: function(respone) {
				if (respone.status !== "200") {
					$('#avatar', '#updateUserInfoModal')[0].value = null;
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật thông tin người dùng";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					document.getElementsByTagName('table')[0].rows[1].cells[0].getElementsByTagName('img')[0].src
					
					let rows = document.getElementsByTagName('table')[0].rows;
					for (let i = 1; i < rows.length; i++){
						if (rows[i].cells[1].innerText == idUser){
							if (respone.newAvatarLink != null){
								rows[i].cells[0].getElementsByTagName('img')[0].src = respone.newAvatarLink;
							}
							rows[i].cells[2].innerText = username;
							rows[i].cells[3].innerText = roleName;
							rows[i].cells[4].innerText = email;
							rows[i].cells[5].innerText = phone;
							rows[i].cells[7].innerText = active == 'true' ? 'Đang hoạt động' : 'Đã vô hiệu hóa';
							break;
						}
					}
					
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Cập nhật thông tin người dùng thành công";
					$("#infoModal").modal('show');
					
					$('#avatar', '#updateUserInfoModal')[0].value = null;
					$("#updateUserInfoModal").modal('hide');
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi cập nhật thông tin người dùng";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idUser: ' + idUser;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function createUser(btn) {
		var formdata = new FormData($("#createNewUserInfoForm")[0]);
		
		$.ajax({
			url: contextPath + '/api/admin/user-api',
			type: 'POST',
			data: formdata,
			cache: false,
			contentType: false,
            processData: false,
			success: function(respone) {
				if (respone.status !== "200") {
					$('#new_avatar', '#createNewUserInfoForm')[0].value = null;
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi tạo người dùng mới";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					$("#createNewUserInfoModal").modal('hide');
					
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Tạo người dùng mới thành công";
					$("#infoModal").modal('show');
					$('#infoModal').on('hidden.bs.modal', function () {
						 location.reload();
					});
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi tạo người dùng mới";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function resetPw(btn) {
		idUser = $(btn.closest('form')).find('#idUserResetForm')[0].value;
		var formdata = new FormData($("#resetPwForm")[0]);
		
		$.ajax({
			url: contextPath + '/api/admin/user-api',
			type: 'POST',
			data: formdata,
			cache: false,
			contentType: false,
            processData: false,
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi đặt lại mật khẩu";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					$("#resetPwModal").modal('hide');
					
					$("#modalInfoMessageTitle")[0].innerText = "Thành công";
					$("#modalInfoMessage")[0].innerText = "Đặt lại mật khẩu thành công";
					$("#infoModal").modal('show');
					$('#infoModal').on('hidden.bs.modal', function () {
						 location.reload();
					})
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi đặt lại mật khẩu";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idUser: ' + idUser;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}

	function showEditUserModal(idUser, idRole, name, phone, email, active){
		$("input[name=idRole][value=" + idRole + "]", '#updateUserInfoForm').prop('checked', true);
		$("input[name=active][value=" + active + "]", '#updateUserInfoForm').prop('checked', true);
		$('#email', '#updateUserInfoForm')[0].value = email;
		$('#phone', '#updateUserInfoForm')[0].value = phone;
		$('#username', '#updateUserInfoForm')[0].value = name;
		$('#idUserUpdateForm', '#updateUserInfoForm')[0].value = idUser;
		$('#avatar', '#updateUserInfoModal')[0].value = null;
		
		$('#updateUserInfoModalTitle')[0].innerText = 'Cập nhật thông tin tài khoản mã ' + idUser;
		$('#updateUserInfoModal').modal('show')
	}
	
	function showResetPwModal(idUser){
		$('#idUserResetForm', '#resetPwForm')[0].value = idUser;
		
		$('#resetPwModalTitle')[0].innerText = 'Đặt lại mật khẩu cho người dùng có mã ' + idUser;
		$('#resetPwModal').modal('show')
	}
	
	function showCreateNewUserModal(){
		$("#new_userRole3").prop("checked", true);
		$("#new_userActive1").prop("checked", true);
		
		$('#new_email', '#createNewUserInfoForm')[0].value = null;
		$('#new_phone', '#createNewUserInfoForm')[0].value = null;
		$('#new_username', '#createNewUserInfoForm')[0].value = null;
		$('#new_avatar', '#createNewUserInfoForm')[0].value = null;
		
		$('#createNewUserInfoModal').modal('show')
	}
</script>