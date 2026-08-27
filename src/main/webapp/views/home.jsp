<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Chủ</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="p-4 mb-4 bg-white rounded card">
            <h2 class="fw-bold mb-2">Hệ Thống Quản Lý Danh Mục</h2>
            <p class="text-muted mb-3">Quản lý danh sách danh mục sản phẩm và thông tin người dùng.</p>
            <div>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/categories">Xem danh mục</a>
                <c:if test="${sessionScope.account == null}">
                    <a class="btn btn-outline-primary ms-2" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                </c:if>
            </div>
        </div>

        <c:if test="${sessionScope.account != null}">
            <div class="row">
                <div class="col-md-8">
                    <div class="card p-4">
                        <h5 class="fw-bold mb-3">Thông Tin Tài Khoản</h5>
                        <table class="table table-bordered mb-0">
                            <tbody>
                                <tr>
                                    <th style="width: 30%;">Tên đăng nhập</th>
                                    <td>${sessionScope.account.userName}</td>
                                </tr>
                                <tr>
                                    <th>Họ và tên</th>
                                    <td>${sessionScope.account.fullName}</td>
                                </tr>
                                <tr>
                                    <th>Email</th>
                                    <td>${sessionScope.account.email}</td>
                                </tr>
                                <tr>
                                    <th>Số điện thoại</th>
                                    <td>${sessionScope.account.phone}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

