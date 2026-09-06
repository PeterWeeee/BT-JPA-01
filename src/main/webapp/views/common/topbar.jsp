<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            Quản Lý Hệ Thống
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/product">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">Danh mục</a>
                </li>
                <c:if test="${sessionScope.account != null and (sessionScope.account.roleid == 1 or sessionScope.account.roleid == 2)}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">Quan ly SP</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.account != null and sessionScope.account.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">Nguoi dung</a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-sm btn-outline-light ms-2 px-3" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <!-- User Avatar/Icon -->
                                <c:choose>
                                    <c:when test="${not empty sessionScope.account.avatar and sessionScope.account.avatar ne 'default-avatar.png'}">
                                        <img src="${pageContext.request.contextPath}/download-image?filename=avatar/${sessionScope.account.avatar}" 
                                             alt="Avatar" 
                                             style="width: 30px; height: 30px; object-fit: cover; border-radius: 50%; border: 2px solid #fff;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person-circle fs-5"></i>
                                    </c:otherwise>
                                </c:choose>
                                <strong class="ms-1">${sessionScope.account.fullName}</strong>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0" aria-labelledby="userDropdown">
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">
                                        <i class="bi bi-person-gear me-2 text-primary"></i>Hồ sơ của tôi
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
