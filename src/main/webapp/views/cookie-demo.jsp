<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản Lý Cookie</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1">Quản Lý Cookie</h3>
                <p class="text-muted mb-0">Danh sách các cookie trên trình duyệt</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                Về trang chủ
            </a>
        </div>

        <c:if test="${param.msg eq 'added'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Đã thêm mới Cookie thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg eq 'deleted'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                Đã xóa Cookie thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-5 mb-3">
                <div class="card p-4">
                    <h5 class="fw-bold mb-3">Thêm Cookie</h5>
                    <form action="${pageContext.request.contextPath}/cookie-demo" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label">Tên Cookie (Key):</label>
                            <input type="text" class="form-control" name="name" placeholder="Ví dụ: theme" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá trị (Value):</label>
                            <input type="text" class="form-control" name="value" placeholder="Ví dụ: light" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">
                            Lưu Cookie
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-md-7 mb-3">
                <div class="card p-4">
                    <h5 class="fw-bold mb-3">Danh Sách Cookie</h5>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Tên Cookie</th>
                                    <th>Giá trị</th>
                                    <th class="text-center" style="width: 100px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty cookiesList}">
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-3">Không có cookie nào.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${cookiesList}" var="c">
                                            <tr>
                                                <td><code>${c.name}</code></td>
                                                <td>${c.value}</td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/cookie-demo?action=delete&name=${c.name}" 
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc muốn xóa cookie này không?')">
                                                        Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

