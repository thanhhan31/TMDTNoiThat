<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<fmt:setLocale value="vi_VN" />

<title>Thêm sản phẩm mới</title>

<style>
	.my-card-img-top {
		width: 100%;
		height: 20rem;
		object-fit: fit;
	}
</style>

<div class="card">
	<div class="card-header">
		<div class="row">
			<div class="col">
				<h3>TẠO SẢN PHẨM MỚI</h3>
			</div>
		</div>
	</div>
	<div class="card-body">
		<form id="productfrm" onsubmit="return false;" enctype="multipart/form-data">
			<div class="form-group row">
				<label for="categorySelect" class="col-sm-2 col-form-label">Loại sản phẩm</label>
				<div class="col-sm-10">
					<select class="form-control" id="categorySelect" name="idCategory">
						<c:forEach items="${categories}" var="c">
							<option value="${c.getId()}">${c.getName()}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group row">
				<label for="name" class="col-sm-2 col-form-label">Tên sản phẩm</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="name" name="name">
				</div>
			</div>
			
			<div class="form-group row">
				<label for="price" class="col-sm-2 col-form-label">Giá bán</label>
				<div class="col-sm-10">
					<input type="number" class="form-control" id="price" name="price">
				</div>
			</div>
			
			<div class="form-group row">
				<label for="availableQty" class="col-sm-2 col-form-label">Số lượng hiện có</label>
				<div class="col-sm-10">
					<input type="number" class="form-control" id="availableQty" name="availableQty">
				</div>
			</div>
			
			<div class = "form-group row">
	            <label for="description" class="col-sm-2 col-form-label">Mô tả sản phẩm</label>
	            <div class="col-sm-10">
					<textarea class="form-control" rows="8" id="description" name="description"></textarea>
				</div>
			</div>
			
			<div class = "form-group row">
	            <label class="col-sm-2 col-form-label">Hình ảnh sản phẩm (tối thiểu 1, đối đa 4 ảnh)</label>
	            <div class="card col-sm-10">
	            	<div class="card-body">
		            	<div class="row">
		            		<c:forEach var="i" begin="1" end="4" varStatus="loop">
		            			<div class="col-3">
			            			<div class="card">
				            			<img id="prev${loop.index}" class="my-card-img-top" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAJFBMVEX4+vvb4OTx9PXl6ezf4+f19/nt8PLz9vfq7fDi5unc4eTs7/GWhAgrAAACGUlEQVR4nO3b23KqMBiAUQEtsn3/961OtydIJEUmaXCtS7n5v5FTEHc7AAAAAAAAAAAAAAAAAAAAAAAAzvr2PX3pgNf6oXnf8Icjjyv0XZxKh8R8rRTYNF+lU8IOqwU2zaF0TNBa++jFsXRM0H7Fwn3pmKAVA5umdEzQhxXuT/3h0B7/bbbwdrpfevopGRIVnq/dZOHT1WzZfUCpiJdu040uZovuVcskzIhNt2g/LVIw5zrcENuwmcLJHdeS3bREwKzrcJO1z+YKJ99h/IZ138bOtCUCZl2HSz8OL/fXkTVXgfnnxaaLnkt/FhDhxPzjJ7hNNzoQY4fhdYUUTMw+fYr7eEn3NPclYCgx+/QpwvPF9tHHNW4gMffwSR4HbK8fxtYWz4v4aWL26VM8F5z68/cXXTuNn1JMEosUzInVJAROEwvMP++dwEli9ulTvBU4Tsw8e5r3AkeJWSdPFaoZ+lNq4HNixrnTBQK73eSC+OpZ7+H+aC7X0L8SDhwlvn6Y3VVW2P3f0KYG1lbY3ba0iYGVFXYPm9q0wLoKu6dtbVJgVYXdaGOb9ItZRYXjwPMyMeUnwXoKp4FpqilcGlhN4eRhW7JaChd/hQpLU5hAYWEfVDgsfrl0qKRwDaVjghTWX7j9dxO3/37pmrtp6ZSIzb/nvdtNnm8v9Gff1f+A/1tcbPw/MwAAAAAAAAAAAAAAAAAAAAAAALl8A7+jEA62Pbx2AAAAAElFTkSuQmCC"/>
				            			<div class="card-body">
					            			<input type="file" class="form-control" id="pimg" name="pimg${loop.index}" onchange="previewImage(this, 'prev${loop.index}')">
				            			</div>
				            			<input type="hidden" name="imgdel">
				            			<div class="card-footer">
				            				<button class="btn btn-primary" onclick="clearImage('prev${loop.index}', this)" hidden>Xóa ảnh</button>
				            			</div>
				            		</div>
		            			</div>
 							</c:forEach>
		            	</div>
	            	
	            	</div>
				</div>
			</div>
			
			<input type="hidden" name="type" value="create">
			<div class="form-group row">
				<div class="col text-center">
					<button type="submit" class="btn btn-primary" onclick="createProduct(this)">Tạo sản phẩm mới</button>
				</div>
			</div>
		</form>
		<div class="text-center">
			<a href="${request.getRequestURL()}" class="btn btn-danger mr-auto ml-auto">Hủy</a>
		</div>
	</div>
</div>


<script>
	function previewImage(inp, imgid){
		var src = URL.createObjectURL(inp.files[0]);
		document.getElementById(imgid).src = src;
		inp.closest('.card').getElementsByTagName('button')[0].hidden = false;
	}
	
	function createProduct(btn) {
		var formdata = new FormData($("#productfrm")[0]);
		
		$.ajax({
			url: contextPath + '/api/seller/product-api',
			type: 'POST',
			data: formdata,
			cache: false,
			contentType: false,
	        processData: false,
			success: function(respone) {
				if (respone.status !== "200") {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi tạo sản phẩm mới";
					$("#modalErrorMessage")[0].innerText = respone.message;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + "/seller/products";
				}
			},
			error: function(xhr) {
				if (xhr.status !== 401) {
					$("#modalErrorMessageTitle")[0].innerText = "Lỗi khi tạo sản phẩm mới";
					$("#modalErrorMessage")[0].innerText = 'HTTP STATUS CODE: ' + xhr.status + ' idUser: ' + idUser;
					$("#errorModal").modal('show');
				}
				else {
					window.location.href = contextPath + '/login';
				}
			}
		});
	}
	
	function clearImage(prepimgid, btn){
		btn.closest('.card').getElementsByTagName('input')[0].value = "";
		document.getElementById(prepimgid).src = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAJFBMVEX4+vvb4OTx9PXl6ezf4+f19/nt8PLz9vfq7fDi5unc4eTs7/GWhAgrAAACGUlEQVR4nO3b23KqMBiAUQEtsn3/961OtydIJEUmaXCtS7n5v5FTEHc7AAAAAAAAAAAAAAAAAAAAAAAAzvr2PX3pgNf6oXnf8Icjjyv0XZxKh8R8rRTYNF+lU8IOqwU2zaF0TNBa++jFsXRM0H7Fwn3pmKAVA5umdEzQhxXuT/3h0B7/bbbwdrpfevopGRIVnq/dZOHT1WzZfUCpiJdu040uZovuVcskzIhNt2g/LVIw5zrcENuwmcLJHdeS3bREwKzrcJO1z+YKJ99h/IZ138bOtCUCZl2HSz8OL/fXkTVXgfnnxaaLnkt/FhDhxPzjJ7hNNzoQY4fhdYUUTMw+fYr7eEn3NPclYCgx+/QpwvPF9tHHNW4gMffwSR4HbK8fxtYWz4v4aWL26VM8F5z68/cXXTuNn1JMEosUzInVJAROEwvMP++dwEli9ulTvBU4Tsw8e5r3AkeJWSdPFaoZ+lNq4HNixrnTBQK73eSC+OpZ7+H+aC7X0L8SDhwlvn6Y3VVW2P3f0KYG1lbY3ba0iYGVFXYPm9q0wLoKu6dtbVJgVYXdaGOb9ItZRYXjwPMyMeUnwXoKp4FpqilcGlhN4eRhW7JaChd/hQpLU5hAYWEfVDgsfrl0qKRwDaVjghTWX7j9dxO3/37pmrtp6ZSIzb/nvdtNnm8v9Gff1f+A/1tcbPw/MwAAAAAAAAAAAAAAAAAAAAAAALl8A7+jEA62Pbx2AAAAAElFTkSuQmCC';
		btn.hidden = true;
	}
</script>