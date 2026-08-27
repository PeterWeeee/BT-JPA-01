<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Quản Lý</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1">Khu Vực Quản Lý</h3>
                <p class="text-muted mb-0">Xin chào, <strong>${currentUser.fullName}</strong></p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-primary">
                    Xem danh mục
                </a>
            </div>
        </div>

        <div class="card p-4">
            <p class="mb-0">
                Tài khoản của bạn có quyền quản lý danh mục và xem các dữ liệu của hệ thống.
            </p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

