<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thông Báo Lỗi - Error Page</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-5 text-center">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card card-custom p-5">
                    <div class="display-1 text-danger mb-3">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                    <h2 class="fw-bold mb-2">Đã Xảy Ra Lỗi!</h2>
                    <p class="text-muted mb-4">
                        Trang bạn yêu cầu không tồn tại hoặc hệ thống đã phát sinh ngoại lệ trong quá trình xử lý (Theo Error Handler trong Slide 01).
                    </p>
                    <div class="d-flex justify-content-center gap-2">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary-custom">
                            <i class="fa-solid fa-right-to-bracket me-1"></i> Trang Đăng Nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                            <i class="fa-solid fa-house me-1"></i> Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
