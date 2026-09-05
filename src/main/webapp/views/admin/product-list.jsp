<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quan Ly San Pham</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="fw-bold mb-0">Quan Ly San Pham</h3>
            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary">
                Them san pham
            </a>
        </div>

        <form class="d-flex gap-2 mb-3" action="${pageContext.request.contextPath}/admin/products" method="get">
            <input type="text" class="form-control form-control-sm" name="keyword"
                   value="${keyword}" placeholder="Tim kiem san pham...">
            <button class="btn btn-sm btn-outline-primary" type="submit">Tim</button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-sm btn-outline-secondary">Xoa loc</a>
            </c:if>
        </form>

        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Anh</th>
                            <th>Ten san pham</th>
                            <th>Danh muc</th>
                            <th>Gia</th>
                            <th>So luong</th>
                            <th>Trang thai</th>
                            <th>Ngay tao</th>
                            <th class="text-center">Thao tac</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listProduct}">
                                <c:forEach var="p" items="${listProduct}" varStatus="st">
                                    <tr>
                                        <td>${st.index + 1}</td>
                                        <td style="width:60px">
                                            <c:choose>
                                                <c:when test="${not empty p.images and not p.images.startsWith('http') and p.images ne 'avatar.png'}">
                                                    <img src="${pageContext.request.contextPath}/download-image?filename=product/${p.images}"
                                                         style="width:50px;height:50px;object-fit:cover;border-radius:4px;" alt="">
                                                </c:when>
                                                <c:when test="${not empty p.images and p.images.startsWith('http')}">
                                                    <img src="${p.images}" style="width:50px;height:50px;object-fit:cover;border-radius:4px;" alt="">
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width:50px;height:50px;background:#f1f5f9;border-radius:4px;display:flex;align-items:center;justify-content:center;color:#94a3b8;font-size:0.7rem;">No img</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
                                               class="text-decoration-none fw-semibold" target="_blank">
                                                ${p.productName}
                                            </a>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.category}">${p.category.categoryname}</c:when>
                                                <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-danger fw-semibold">
                                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>d
                                        </td>
                                        <td>${p.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.status == 1}">
                                                    <span class="badge bg-success">Hien thi</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">An</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${p.createdDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}"
                                               class="btn btn-sm btn-outline-warning me-1">Sua</a>
                                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}"
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Ban co chac muon xoa san pham nay khong?')">Xoa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="text-center py-4 text-muted">
                                        Chua co san pham nao.
                                        <a href="${pageContext.request.contextPath}/admin/product/add">Them ngay</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
