<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Quản Lý - Manager Area</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-warning">
                    <i class="fa-solid fa-user-tie me-2"></i>Khu Vực Dành Cho Quản Lý (Manager Area)
                </h2>
                <p class="text-muted mb-0">Dành cho tài khoản có <strong>Role ID = 2 (Manager)</strong> hoặc <strong>Role ID = 1 (Admin)</strong>.</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Về Trang Chủ
            </a>
        </div>

        <div class="card card-custom p-4">
            <div class="alert alert-info">
                <h5><i class="fa-solid fa-circle-check me-2"></i>Xác thực thành công với quyền Manager!</h5>
                <p class="mb-0">
                    Xin chào <strong>${currentUser.fullName}</strong> (${currentUser.userName}). Bạn đang ở giao diện chức năng dành riêng cho cấp quản lý.
                </p>
            </div>
        </div>

    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
