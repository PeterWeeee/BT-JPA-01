<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thông Báo Lỗi</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-5 text-center">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card p-5">
                    <h3 class="fw-bold mb-2">Đã Xảy Ra Lỗi</h3>
                    <p class="text-muted mb-4">
                        Trang bạn yêu cầu không tồn tại hoặc hệ thống đã phát sinh lỗi trong quá trình xử lý.
                    </p>
                    <div class="d-flex justify-content-center gap-2">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                            Về trang chủ
                        </a>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary">
                            Đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

