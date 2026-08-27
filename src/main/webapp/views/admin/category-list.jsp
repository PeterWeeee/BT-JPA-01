<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category List</title>
<jsp:include page="/views/common/header.jsp" />
</head>
<body>
<jsp:include page="/views/common/topbar.jsp" />

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-primary">Quản Lý Danh Mục (JPA CRUD)</h2>
            <p class="text-muted mb-0">Thực hiện thêm, sửa, xóa danh mục sản phẩm bằng JPA</p>
        </div>
        <div>
            <a href="<c:url value="/admin/category/add"/>" class="btn btn-primary">
                + Thêm Danh Mục Mới
            </a>
        </div>
    </div>

    <div class="card p-4 shadow-sm">
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark">
                <tr>
                    <th class="text-center" style="width: 70px;">STT</th>
                    <th class="text-center" style="width: 140px;">Images</th>
                    <th>Category name</th>
                    <th class="text-center" style="width: 130px;">Status</th>
                    <th class="text-center" style="width: 160px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty listcate}">
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">Chưa có danh mục nào trong hệ thống!</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center fw-bold">${STT.index + 1}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${cate.images != null && cate.images.startsWith('http')}">
                                            <c:url value="${cate.images}" var="imgUrl" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${imgUrl}" alt="${cate.categoryname}" class="rounded border" style="width: 90px; height: 65px; object-fit: cover;" onerror="this.src='https://via.placeholder.com/90x65?text=No+Image'" />
                                </td>
                                <td class="fw-semibold">
                                    ${cate.categoryname}
                                    <div class="small text-muted">ID: #${cate.categoryId}</div>
                                </td>
                                <td class="text-center">
                                    <c:if test="${cate.status == 1}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:if>
                                    <c:if test="${cate.status != 1}">
                                        <span class="badge bg-secondary">Khóa</span>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="btn btn-sm btn-outline-warning text-dark me-1">Sửa</a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${cate.categoryname}] không?')">Xóa</a>
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
