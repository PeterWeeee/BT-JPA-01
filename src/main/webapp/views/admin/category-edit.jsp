<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh Sửa Danh Mục - Edit Category</title>
<jsp:include page="/views/common/header.jsp" />
</head>
<body>
<jsp:include page="/views/common/topbar.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card p-4 shadow-sm">
                <h3 class="fw-bold text-dark mb-3">Cập Nhật Danh Mục (JPA)</h3>

                <form action="<c:url value="/admin/category/update"/>" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="categoryid" value="${cate.categoryId}">

                    <div class="mb-3">
                        <label for="categoryname" class="form-label fw-semibold">Category name <span class="text-danger">*</span>:</label>
                        <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}" required>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">Link images (URL):</label>
                        <input type="text" class="form-control" id="images" name="images" value="${cate.images}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold d-block">Ảnh hiện tại:</label>
                        <c:choose>
                            <c:when test="${cate.images != null && cate.images.startsWith('http')}">
                                <c:url value="${cate.images}" var="imgUrl" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" alt="${cate.categoryname}" class="rounded border mb-2" style="width: 100px; height: 75px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/100x75?text=No+Image'" />
                    </div>

                    <div class="mb-3">
                        <label for="images1" class="form-label fw-semibold">Upload images mới (Nếu muốn thay đổi):</label>
                        <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold d-block">Status:</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                            <label class="form-check-label text-success fw-semibold" for="ston">Hoạt động</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                            <label class="form-check-label text-danger fw-semibold" for="stoff">Khóa</label>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-warning flex-grow-1 text-dark fw-semibold">Update</button>
                        <a href="<c:url value="/admin/categories"/>" class="btn btn-outline-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
