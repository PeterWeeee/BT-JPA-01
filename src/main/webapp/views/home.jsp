<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Chu</title>
    <jsp:include page="/views/common/header.jsp" />
    <style>
        .product-card { transition: transform 0.2s, box-shadow 0.2s; cursor: pointer; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.12) !important; }
        .product-img { width: 100%; height: 200px; object-fit: cover; border-radius: 6px 6px 0 0; }
        .price-badge { color: #ef4444; font-weight: 700; font-size: 1.05rem; }
        .img-placeholder { background: #f1f5f9; display: flex; align-items: center; justify-content: center; color: #94a3b8; font-size: 0.85rem; }
    </style>
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">

        <%-- Hero Banner --%>
        <div class="p-4 mb-4 bg-white rounded card">
            <h2 class="fw-bold mb-2">Chao Mung Den IoTStar Shop</h2>
            <p class="text-muted mb-3">Kham pha hang nghin san pham chat luong voi gia tot nhat.</p>
            <div>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/product">Xem tat ca san pham</a>
                <a class="btn btn-outline-secondary ms-2" href="${pageContext.request.contextPath}/admin/categories">Danh muc</a>
                <c:if test="${sessionScope.account == null}">
                    <a class="btn btn-outline-primary ms-2" href="${pageContext.request.contextPath}/login">Dang nhap</a>
                </c:if>
            </div>
        </div>

        <%-- 10 San pham moi nhat --%>
        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="fw-bold mb-0">San Pham Moi Nhat</h4>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-sm btn-outline-primary">Xem tat ca</a>
            </div>

            <c:choose>
                <c:when test="${not empty latestProducts}">
                    <div class="row row-cols-2 row-cols-md-4 row-cols-lg-5 g-3">
                        <c:forEach var="p" items="${latestProducts}">
                            <div class="col">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
                                   class="text-decoration-none text-dark">
                                    <div class="card product-card h-100">
                                        <c:choose>
                                            <c:when test="${not empty p.images and not p.images.startsWith('http') and p.images ne 'avatar.png'}">
                                                <img src="${pageContext.request.contextPath}/download-image?filename=product/${p.images}"
                                                     alt="${p.productName}" class="product-img">
                                            </c:when>
                                            <c:when test="${not empty p.images and p.images.startsWith('http')}">
                                                <img src="${p.images}" alt="${p.productName}" class="product-img">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="product-img img-placeholder">Chua co anh</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-body p-2">
                                            <p class="mb-1 small fw-semibold" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis">${p.productName}</p>
                                            <span class="price-badge"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>d</span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 text-muted">
                        <p class="mt-2">Chua co san pham nao. <a href="${pageContext.request.contextPath}/admin/product/add">Them san pham dau tien</a></p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Thong tin tai khoan (neu da dang nhap) --%>
        <c:if test="${sessionScope.account != null}">
            <div class="row">
                <div class="col-md-8">
                    <div class="card p-4">
                        <h5 class="fw-bold mb-3">Thong Tin Tai Khoan</h5>
                        <table class="table table-bordered mb-0">
                            <tbody>
                                <tr>
                                    <th style="width: 30%;">Ten dang nhap</th>
                                    <td>${sessionScope.account.userName}</td>
                                </tr>
                                <tr>
                                    <th>Ho va ten</th>
                                    <td>${sessionScope.account.fullName}</td>
                                </tr>
                                <tr>
                                    <th>Email</th>
                                    <td>${sessionScope.account.email}</td>
                                </tr>
                                <tr>
                                    <th>So dien thoai</th>
                                    <td>${sessionScope.account.phone}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
