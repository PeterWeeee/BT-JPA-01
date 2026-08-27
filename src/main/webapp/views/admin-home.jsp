<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Quản Trị Hệ Thống - Admin Dashboard</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-danger">
                    <i class="fa-solid fa-shield-halved me-2"></i>Bảng Điều Khiển Quản Trị (Admin Area)
                </h2>
                <p class="text-muted mb-0">Chỉ người dùng có <strong>Role ID = 1</strong> mới có quyền truy cập trang này.</p>
            </div>
            <div class="mt-2 mt-md-0 d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-primary-custom">
                    <i class="fa-solid fa-folder-tree me-1"></i> Quản Lý Danh Mục (CRUD)
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i> Về Trang Chủ
                </a>
            </div>
        </div>

        <div class="card card-custom p-4 mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-primary mb-0">
                    <i class="fa-solid fa-users me-2"></i>Danh Sách Tài Khoản Trong Hệ Thống (SQL Server)
                </h5>
                <span class="badge bg-secondary">Tổng cộng: ${userList.size()} tài khoản</span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" style="width: 60px;">ID</th>
                            <th>Tên Đăng Nhập</th>
                            <th>Họ và Tên</th>
                            <th>Email</th>
                            <th>Điện Thoại</th>
                            <th class="text-center">Vai Trò</th>
                            <th>Ngày Tạo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="u">
                            <tr>
                                <td class="text-center fw-bold">#${u.id}</td>
                                <td><code>${u.userName}</code></td>
                                <td class="fw-semibold">${u.fullName}</td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${u.roleid == 1}">
                                            <span class="badge badge-role-1">Admin</span>
                                        </c:when>
                                        <c:when test="${u.roleid == 2}">
                                            <span class="badge badge-role-2">Manager</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-role-3">User</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${u.createdDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
