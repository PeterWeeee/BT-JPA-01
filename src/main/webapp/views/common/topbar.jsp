<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fa-solid fa-layer-group text-primary me-2"></i>LoginMVC 3-Tier
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fa-solid fa-house me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/list">
                        <i class="fa-solid fa-folder-tree me-1"></i>Quản Lý Danh Mục (CRUD)
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/cookie-demo">
                        <i class="fa-solid fa-cookie-bite me-1"></i>Demo Cookie
                    </a>
                </li>
                <c:if test="${sessionScope.account != null and sessionScope.account.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/home">
                            <i class="fa-solid fa-shield-halved me-1"></i>Trang Admin
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.account != null and (sessionScope.account.roleid == 1 or sessionScope.account.roleid == 2)}">
                    <li class="nav-item">
                        <a class="nav-link text-info fw-semibold" href="${pageContext.request.contextPath}/manager/home">
                            <i class="fa-solid fa-user-tie me-1"></i>Trang Manager
                        </a>
                    </li>
                </c:if>
            </ul>

            <!-- Kiểm tra Session người dùng (Theo Slide 06) -->
            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/login">
                                <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng Nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-sm btn-outline-light ms-2 px-3" href="${pageContext.request.contextPath}/register">
                                <i class="fa-solid fa-user-plus me-1"></i>Đăng Ký
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-3 text-light">
                            <i class="fa-solid fa-circle-user text-success me-1"></i>
                            Xin chào, <strong>${sessionScope.account.fullName}</strong>
                            <c:choose>
                                <c:when test="${sessionScope.account.roleid == 1}">
                                    <span class="badge badge-role-1 ms-1">Admin</span>
                                </c:when>
                                <c:when test="${sessionScope.account.roleid == 2}">
                                    <span class="badge badge-role-2 ms-1">Manager</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-role-3 ms-1">User</span>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-sm btn-danger px-3" href="${pageContext.request.contextPath}/logout">
                                <i class="fa-solid fa-power-off me-1"></i>Đăng Xuất
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
