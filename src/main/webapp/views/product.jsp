<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>San Pham</title>
    <jsp:include page="/views/common/header.jsp" />
    <style>
        .product-card { transition: transform 0.2s, box-shadow 0.2s; cursor: pointer; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.12) !important; }
        .product-img { width: 100%; height: 220px; object-fit: cover; border-radius: 6px 6px 0 0; }
        .price-badge { color: #ef4444; font-weight: 700; font-size: 1.1rem; }
        .img-placeholder { background: #f1f5f9; display: flex; align-items: center; justify-content: center; color: #94a3b8; font-size: 0.85rem; }
    </style>
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0">Tat Ca San Pham</h3>
            <form class="d-flex gap-2" action="${pageContext.request.contextPath}/product" method="get">
                <input type="text" class="form-control form-control-sm" name="keyword"
                       value="${keyword}" placeholder="Tim kiem san pham...">
                <button class="btn btn-sm btn-primary" type="submit">Tim</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-sm btn-outline-secondary">Xoa</a>
                </c:if>
            </form>
        </div>

        <c:if test="${not empty keyword}">
            <p class="text-muted mb-3">Ket qua tim kiem: <strong>"${keyword}"</strong></p>
        </c:if>

        <c:choose>
            <c:when test="${not empty products}">
                <div class="row row-cols-2 row-cols-md-3 g-4">
                    <c:forEach var="p" items="${products}">
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
                                    <div class="card-body">
                                        <h6 class="card-title fw-semibold mb-2">${p.productName}</h6>
                                        <p class="card-text text-muted small mb-2"
                                           style="overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;">
                                            ${p.description}
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="price-badge">
                                                <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>d
                                            </span>
                                            <span class="badge bg-light text-muted">Con: ${p.quantity}</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${totalPages > 1}">
                    <nav class="mt-4" aria-label="Phan trang san pham">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/product?page=${currentPage - 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}">
                                    Truoc
                                </a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/product?page=${i}${not empty keyword ? '&keyword='.concat(keyword) : ''}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/product?page=${currentPage + 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}">
                                    Sau
                                </a>
                            </li>
                        </ul>
                        <p class="text-center text-muted small">
                            Trang ${currentPage} / ${totalPages}
                        </p>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <h5 class="mt-3 text-muted">
                        <c:choose>
                            <c:when test="${not empty keyword}">Khong tim thay san pham nao!</c:when>
                            <c:otherwise>Chua co san pham nao.</c:otherwise>
                        </c:choose>
                    </h5>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary mt-3">Trang chu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
