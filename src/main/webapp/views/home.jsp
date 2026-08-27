<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Chủ - LoginMVC 3-Tier</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        
        <!-- Banner giới thiệu -->
        <div class="p-5 mb-4 bg-white rounded-3 card-custom">
            <div class="container-fluid py-2">
                <h1 class="display-6 fw-bold text-primary">
                    <i class="fa-solid fa-graduation-cap me-2"></i>Ứng Dụng Java Web MVC 3 Tầng
                </h1>
                <p class="col-md-10 fs-5 text-muted">
                    Dự án minh họa đầy đủ <strong>Kiến trúc 3 Tầng</strong>, <strong>Đăng nhập với Session</strong>, <strong>Ghi nhớ với Cookie</strong> và kết nối <strong>Microsoft SQL Server</strong> qua JDBC.
                </p>
                <div class="d-flex gap-2">
                    <a class="btn btn-primary-custom" href="${pageContext.request.contextPath}/cookie-demo">
                        <i class="fa-solid fa-cookie-bite me-1"></i> Trải Nghiệm Demo Cookie
                    </a>
                    <c:if test="${sessionScope.account == null}">
                        <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login">
                            <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng Nhập Hệ Thống
                        </a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Thông tin người dùng khi đã đăng nhập (Session Scope) -->
        <c:choose>
            <c:when test="${sessionScope.account != null}">
                <div class="row mb-4">
                    <div class="col-lg-8">
                        <div class="card card-custom p-4">
                            <h4 class="fw-bold mb-3 text-success">
                                <i class="fa-solid fa-id-card me-2"></i>Thông Tin Phiên Đăng Nhập (HttpSession)
                            </h4>
                            <table class="table table-bordered table-striped align-middle mb-0">
                                <tbody>
                                    <tr>
                                        <th style="width: 25%;">User ID</th>
                                        <td><code>#${sessionScope.account.id}</code></td>
                                    </tr>
                                    <tr>
                                        <th>Tên Đăng Nhập</th>
                                        <td><strong>${sessionScope.account.userName}</strong></td>
                                    </tr>
                                    <tr>
                                        <th>Họ và Tên</th>
                                        <td>${sessionScope.account.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Email</th>
                                        <td>${sessionScope.account.email}</td>
                                    </tr>
                                    <tr>
                                        <th>Số Điện Thoại</th>
                                        <td>${sessionScope.account.phone}</td>
                                    </tr>
                                    <tr>
                                        <th>Vai Trò (Role ID)</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${sessionScope.account.roleid == 1}">
                                                    <span class="badge badge-role-1 fs-6">Role 1: Admin (Toàn quyền)</span>
                                                </c:when>
                                                <c:when test="${sessionScope.account.roleid == 2}">
                                                    <span class="badge badge-role-2 fs-6">Role 2: Manager (Quản lý)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-role-3 fs-6">Role 3: User Thường</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Ngày Tạo</th>
                                        <td>${sessionScope.account.createdDate}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card card-custom p-4 h-100">
                            <h5 class="fw-bold mb-3 text-primary">
                                <i class="fa-solid fa-bolt me-1"></i>Thao Tác Nhanh
                            </h5>
                            <div class="d-grid gap-2">
                                <c:if test="${sessionScope.account.roleid == 1}">
                                    <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-warning text-dark fw-semibold">
                                        <i class="fa-solid fa-shield-halved me-1"></i> Truy Cập Trang Admin
                                    </a>
                                </c:if>
                                <c:if test="${sessionScope.account.roleid == 1 or sessionScope.account.roleid == 2}">
                                    <a href="${pageContext.request.contextPath}/manager/home" class="btn btn-info text-dark fw-semibold">
                                        <i class="fa-solid fa-user-tie me-1"></i> Truy Cập Trang Manager
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/cookie-demo" class="btn btn-outline-secondary">
                                    <i class="fa-solid fa-cookie me-1"></i> Kiểm Tra Trạng Thái Cookie
                                </a>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">
                                    <i class="fa-solid fa-power-off me-1"></i> Đăng Xuất (Hủy Session)
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning card-custom p-4" role="alert">
                    <h5 class="alert-heading fw-bold">
                        <i class="fa-solid fa-triangle-exclamation me-2"></i>Bạn chưa đăng nhập vào hệ thống!
                    </h5>
                    <p class="mb-3">
                        Vui lòng đăng nhập để trải nghiệm cơ chế lưu phiên bằng <strong>HttpSession</strong> và tự động ghi nhớ tài khoản bằng <strong>Cookie</strong>.
                    </p>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary-custom">
                        <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng Nhập Ngay
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
