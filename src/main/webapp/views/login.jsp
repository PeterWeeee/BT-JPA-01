<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng Nhập</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card p-4">
                    <h4 class="fw-bold text-center mb-3">Đăng Nhập</h4>

                    <%-- Thong bao dang ky thanh cong --%>
                    <c:if test="${param.registered eq 'success'}">
                        <div class="alert alert-success py-2 mb-3" role="alert">
                            Dang ky tai khoan thanh cong! Ban co the dang nhap ngay.
                        </div>
                    </c:if>

                    <%-- Thong bao kich hoat tai khoan thanh cong --%>
                    <c:if test="${param.activated eq 'success'}">
                        <div class="alert alert-success py-2 mb-3" role="alert">
                            Tai khoan da duoc kich hoat thanh cong! Ban co the dang nhap ngay.
                        </div>
                    </c:if>

                    <%-- Thong bao dat lai mat khau thanh cong --%>
                    <c:if test="${param.reset eq 'success'}">
                        <div class="alert alert-success py-2 mb-3" role="alert">
                            Mat khau da duoc dat lai thanh cong!
                        </div>
                    </c:if>

                    <%-- Thông báo lỗi --%>
                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 mb-3" role="alert">
                            ${alert}
                            <c:if test="${showActivateLink}">
                                <br>
                                <a href="${pageContext.request.contextPath}/verify-otp?email=${pendingEmail}&type=activate"
                                   class="alert-link">→ Kích hoạt tài khoản ngay</a>
                            </c:if>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập:</label>
                            <input type="text" 
                                   class="form-control" 
                                   placeholder="Nhập tên đăng nhập" 
                                   name="username" 
                                   value="${rememberedUser}" 
                                   required autofocus>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mật khẩu:</label>
                            <input type="password" 
                                   class="form-control" 
                                   placeholder="Nhập mật khẩu" 
                                   name="password" 
                                   required>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="form-check">
                                <input class="form-check-input" 
                                       type="checkbox" 
                                       name="remember" 
                                       id="rememberMe"
                                       <c:if test="${isRemembered}">checked</c:if>>
                                <label class="form-check-label" for="rememberMe">
                                    Ghi nhớ đăng nhập
                                </label>
                            </div>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="text-muted small">
                                Quên mật khẩu?
                            </a>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary">
                                Đăng Nhập
                            </button>
                        </div>

                        <div class="text-center text-muted small">
                            Chưa có tài khoản? 
                            <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
