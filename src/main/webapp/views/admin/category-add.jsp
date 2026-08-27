<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm Danh Mục</title>
<jsp:include page="/views/common/header.jsp" />
</head>
<body>
<jsp:include page="/views/common/topbar.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4">
                <h4 class="fw-bold mb-3">Thêm Danh Mục Mới</h4>

                <c:if test="${alert != null}">
                    <div class="alert alert-danger py-2 mb-3" role="alert">
                        ${alert}
                    </div>
                </c:if>
                
                <form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="categoryname" class="form-label">Tên danh mục <span class="text-danger">*</span>:</label>
                        <input type="text" class="form-control" id="categoryname" name="categoryname" value="${categoryname}" placeholder="Nhập tên danh mục..." required autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label">Đường dẫn ảnh (URL):</label>
                        <input type="text" class="form-control" id="images" name="images" value="${images}" placeholder="https://example.com/image.png">
                    </div>

                    <div class="mb-3">
                        <label for="images1" class="form-label">Hoặc tải ảnh từ máy:</label>
                        <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                    </div>

                    <div class="mb-4">
                        <label class="form-label d-block">Trạng thái:</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${status == 0 ? '' : 'checked'}>
                            <label class="form-check-label text-success" for="ston">Hoạt động</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${status == 0 ? 'checked' : ''}>
                            <label class="form-check-label text-danger" for="stoff">Khóa</label>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary flex-grow-1">Thêm mới</button>
                        <a href="<c:url value="/admin/categories"/>" class="btn btn-outline-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
