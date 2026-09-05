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
                        <li class="nav-item me-3 text-light">
                            Xin chào, <strong>${sessionScope.account.fullName}</strong>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-sm btn-danger px-3" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

