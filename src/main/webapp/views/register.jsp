<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng Ký Tài Khoản - LoginMVC 3-Tier</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <div class="card card-custom p-4 p-md-5">
                    
                    <div class="text-center mb-4">
                        <div class="display-6 text-success mb-2">
                            <i class="fa-solid fa-user-plus"></i>
                        </div>
                        <h3 class="fw-bold">Tạo Tài Khoản Mới</h3>
                        <p class="text-muted small">Đăng ký tài khoản hệ thống (Theo Slide 06)</p>
                    </div>

                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${alert != null}">
                        <div class="alert alert-danger d-flex align-items-center py-2 mb-3" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>
                            <div>${alert}</div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        
                        <!-- Tên đăng nhập -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="username" placeholder="Ví dụ: nguyenvana" required>
                        </div>

                        <!-- Họ và tên -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Họ và tên</label>
                            <input type="text" class="form-control" name="fullname" placeholder="Ví dụ: Nguyễn Văn A">
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" placeholder="name@example.com" required>
                        </div>

                        <!-- Số điện thoại -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" class="form-control" name="phone" placeholder="Ví dụ: 0901234567">
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" required>
                        </div>

                        <!-- Nút Submit -->
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-success py-2 fw-semibold">
                                <i class="fa-solid fa-check me-1"></i> Đăng Ký Tài Khoản
                            </button>
                        </div>

                        <div class="text-center text-muted small">
                            Đã có tài khoản? 
                            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-primary text-decoration-none">
                                Đăng nhập tại đây
                            </a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
