<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng Nhập - Login with Session & Cookie</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card card-custom p-4 p-md-5">
                    
                    <div class="text-center mb-4">
                        <div class="display-6 text-primary mb-2">
                            <i class="fa-solid fa-user-shield"></i>
                        </div>
                        <h3 class="fw-bold">Đăng Nhập</h3>
                        <p class="text-muted small">Kiến trúc 3 Tầng MVC - Session & Cookie Remember Me</p>
                    </div>

                    <!-- Hiển thị thông báo khi đăng ký thành công -->
                    <c:if test="${param.registered eq 'success'}">
                        <div class="alert alert-success d-flex align-items-center py-2 mb-3" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i>
                            <div>Đăng ký tài khoản thành công! Bạn có thể đăng nhập ngay.</div>
                        </div>
                    </c:if>

                    <!-- Hiển thị thông báo lỗi (Theo Slide 06) -->
                    <c:if test="${alert != null}">
                        <div class="alert alert-danger d-flex align-items-center py-2 mb-3" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>
                            <div>${alert}</div>
                        </div>
                    </c:if>

                    <!-- Form Đăng nhập gửi POST tới /login (Theo Slide 01 & Slide 06) -->
                    <form action="${pageContext.request.contextPath}/login" method="post">
                        
                        <!-- Tên đăng nhập -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="fa-solid fa-user me-1 text-secondary"></i>Tên đăng nhập:
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-at"></i></span>
                                <input type="text" 
                                       class="form-control" 
                                       placeholder="Nhập username" 
                                       name="username" 
                                       value="${rememberedUser}" 
                                       required autofocus>
                            </div>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="fa-solid fa-lock me-1 text-secondary"></i>Mật khẩu:
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-key"></i></span>
                                <input type="password" 
                                       class="form-control" 
                                       placeholder="Nhập mật khẩu" 
                                       name="password" 
                                       required>
                            </div>
                        </div>

                        <!-- Checkbox Ghi nhớ đăng nhập (Cookie Remember Me) -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" 
                                       type="checkbox" 
                                       name="remember" 
                                       id="rememberMe"
                                       <c:if test="${isRemembered}">checked</c:if>>
                                <label class="form-check-label small" for="rememberMe">
                                    Nhớ tài khoản (Cookie 24h)
                                </label>
                            </div>
                            <a href="${pageContext.request.contextPath}/cookie-demo" class="small text-decoration-none">
                                Xem Cookies <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>

                        <!-- Nút Đăng nhập -->
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary-custom py-2">
                                <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập
                            </button>
                        </div>

                        <!-- Chuyển sang Đăng ký -->
                        <div class="text-center text-muted small">
                            Chưa có tài khoản? 
                            <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-primary text-decoration-none">
                                Đăng ký ngay
                            </a>
                        </div>
                    </form>

                    <!-- Danh sách tài khoản thử nghiệm nhanh -->
                    <hr class="my-4">
                    <div class="bg-light p-3 rounded">
                        <div class="fw-bold small text-secondary mb-2">
                            <i class="fa-solid fa-circle-info me-1"></i>Tài khoản mẫu có sẵn:
                        </div>
                        <ul class="list-unstyled small mb-0">
                            <li>• <strong>Admin</strong>: <code>admin</code> / <code>123</code> (Role 1)</li>
                            <li>• <strong>Manager</strong>: <code>manager</code> / <code>123</code> (Role 2)</li>
                            <li>• <strong>User</strong>: <code>user</code> / <code>123</code> (Role 3)</li>
                            <li>• <strong>Thầy Trung</strong>: <code>trungnh</code> / <code>123</code> (Role 1)</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
