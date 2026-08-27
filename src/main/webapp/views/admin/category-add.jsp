<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Danh Mục - Add Category</title>
<jsp:include page="/views/common/header.jsp" />
</head>
<body>
<jsp:include page="/views/common/topbar.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card p-4 shadow-sm">
                <h3 class="fw-bold text-primary mb-3">Thêm Danh Mục Mới (JPA)</h3>
                
                <form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="categoryname" class="form-label fw-semibold">Category name <span class="text-danger">*</span>:</label>
                        <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Nhập tên danh mục..." required autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">Link images (URL):</label>
                        <input type="text" class="form-control" id="images" name="images" placeholder="https://example.com/image.png">
                    </div>

                    <div class="mb-3">
                        <label for="images1" class="form-label fw-semibold">Upload images (Tệp từ máy tính):</label>
                        <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold d-block">Status:</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="ston" name="status" value="1" checked>
                            <label class="form-check-label text-success fw-semibold" for="ston">Hoạt động</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="stoff" name="status" value="0">
                            <label class="form-check-label text-danger fw-semibold" for="stoff">Khóa</label>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary flex-grow-1">Insert</button>
                        <a href="<c:url value="/admin/categories"/>" class="btn btn-outline-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
