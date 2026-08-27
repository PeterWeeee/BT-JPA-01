<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Danh Sách Danh Mục</title>
<jsp:include page="/views/common/header.jsp" />
</head>
<body>
<jsp:include page="/views/common/topbar.jsp" />

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1">Quản Lý Danh Mục</h3>
            <p class="text-muted mb-0">Danh sách các danh mục sản phẩm trong hệ thống</p>
        </div>
        <div>
            <a href="<c:url value="/admin/category/add"/>" class="btn btn-primary">
                + Thêm mới
            </a>
        </div>
    </div>

    <!-- Thanh tìm kiếm -->
    <div class="card p-3 mb-3">
        <form action="<c:url value="/admin/categories"/>" method="get" class="row g-2 align-items-center">
            <div class="col-auto flex-grow-1">
                <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm theo tên danh mục..." value="${keyword}">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
                <c:if test="${not empty keyword}">
                    <a href="<c:url value="/admin/categories"/>" class="btn btn-outline-secondary">Xóa lọc</a>
                </c:if>
            </div>
        </form>
    </div>

    <div class="card p-3">
        <table class="table table-hover table-bordered align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th class="text-center" style="width: 60px;">STT</th>
                    <th class="text-center" style="width: 120px;">Hình ảnh</th>
                    <th>Tên danh mục</th>
                    <th class="text-center" style="width: 130px;">Trạng thái</th>
                    <th class="text-center" style="width: 150px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty listcate}">
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">Không tìm thấy danh mục nào.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center">${STT.index + 1}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${cate.images != null && cate.images.startsWith('http')}">
                                            <c:url value="${cate.images}" var="imgUrl" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${imgUrl}" alt="${cate.categoryname}" class="border rounded" style="width: 80px; height: 55px; object-fit: cover;" onerror="this.src='<c:url value="/image?fname="/>'" />
                                </td>
                                <td>
                                    <strong>${cate.categoryname}</strong>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${cate.status == 1}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="btn btn-sm btn-outline-primary me-1">Sửa</a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
