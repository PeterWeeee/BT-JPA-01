<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${product.productName} - IoTStar Shop</title>
    <jsp:include page="/views/common/header.jsp" />
    <style>
        .product-main-img { width: 100%; max-height: 420px; object-fit: contain; border-radius: 8px; border: 1px solid #e2e8f0; }
        .price-text { color: #ef4444; font-size: 1.8rem; font-weight: 700; }
        .badge-category { background: #eff6ff; color: #3b82f6; border-radius: 20px; padding: 4px 12px; font-size: 0.85rem; }
        .img-placeholder { background: #f1f5f9; min-height: 300px; display: flex; align-items: center; justify-content: center; color: #94a3b8; border-radius: 8px; border: 1px solid #e2e8f0; }
    </style>
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">

        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chu</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product">San pham</a></li>
                <li class="breadcrumb-item active">${product.productName}</li>
            </ol>
        </nav>

        <div class="card p-4">
            <div class="row">
                <div class="col-md-5 mb-4 mb-md-0">
                    <c:choose>
                        <c:when test="${not empty product.images and not product.images.startsWith('http') and product.images ne 'avatar.png'}">
                            <img src="${pageContext.request.contextPath}/download-image?filename=product/${product.images}"
                                 alt="${product.productName}" class="product-main-img">
                        </c:when>
                        <c:when test="${not empty product.images and product.images.startsWith('http')}">
                            <img src="${product.images}" alt="${product.productName}" class="product-main-img">
                        </c:when>
                        <c:otherwise>
                            <div class="img-placeholder">Chua co anh san pham</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="col-md-7">
                    <c:if test="${not empty product.category}">
                        <span class="badge-category mb-2 d-inline-block">${product.category.categoryname}</span>
                    </c:if>

                    <h2 class="fw-bold mt-2 mb-2">${product.productName}</h2>

                    <div class="price-text mb-3">
                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>d
                    </div>

                    <div class="mb-3">
                        <span class="text-muted">Tinh trang: </span>
                        <c:choose>
                            <c:when test="${product.quantity > 0}">
                                <span class="badge bg-success">Con hang (${product.quantity} san pham)</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Het hang</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <hr>

                    <div class="mb-3">
                        <h6 class="fw-semibold">Mo ta san pham:</h6>
                        <p class="text-muted" style="white-space: pre-wrap;">${not empty product.description ? product.description : 'Khong co mo ta.'}</p>
                    </div>

                    <hr>

                    <div class="text-muted small">
                        <c:if test="${not empty product.createdDate}">
                            <span>Ngay them: <fmt:formatDate value="${product.createdDate}" pattern="dd/MM/yyyy"/></span>
                        </c:if>
                    </div>

                    <div class="mt-3 d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary">
                            Quay lai danh sach
                        </a>
                        <c:if test="${sessionScope.account != null and (sessionScope.account.roleid == 1 or sessionScope.account.roleid == 2)}">
                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}"
                               class="btn btn-outline-warning">Sua san pham</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
