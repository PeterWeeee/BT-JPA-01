<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Demo Quản Lý Cookie trong Servlet</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary">
                    <i class="fa-solid fa-cookie-bite me-2"></i>Thực Hành Quản Lý Cookie (Theo Slide 01)
                </h2>
                <p class="text-muted mb-0">Minh họa các phương thức: <code>Cookie()</code>, <code>addCookie()</code>, <code>getCookies()</code>, <code>setMaxAge(0)</code></p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Về Trang Chủ
            </a>
        </div>

        <c:if test="${param.msg eq 'added'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>Đã thêm mới Cookie thành công vào trình duyệt!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg eq 'deleted'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-trash-can me-2"></i>Đã xóa Cookie thành công bằng cách set <code>setMaxAge(0)</code>!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <!-- Form Thêm Cookie Mới -->
            <div class="col-lg-5 mb-4">
                <div class="card card-custom p-4">
                    <h5 class="fw-bold mb-3 text-success">
                        <i class="fa-solid fa-plus-circle me-1"></i>Thêm Cookie Mới
                    </h5>
                    <form action="${pageContext.request.contextPath}/cookie-demo" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên Cookie (Key):</label>
                            <input type="text" class="form-control" name="name" placeholder="Ví dụ: myTheme hoặc username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Giá Trị Cookie (Value):</label>
                            <input type="text" class="form-control" name="value" placeholder="Ví dụ: darkmode hoặc nguyenvana" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100 py-2">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Cookie (24h)
                        </button>
                    </form>
                </div>
            </div>

            <!-- Bảng Hiển thị Danh Sách Cookie Hiện Có -->
            <div class="col-lg-7 mb-4">
                <div class="card card-custom p-4">
                    <h5 class="fw-bold mb-3 text-primary">
                        <i class="fa-solid fa-list-check me-1"></i>Danh Sách Cookies Đang Lưu Tại Client
                    </h5>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Tên Cookie (Name)</th>
                                    <th>Giá Trị (Value)</th>
                                    <th class="text-center" style="width: 100px;">Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty cookiesList}">
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-3">Không có cookie nào!</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${cookiesList}" var="c">
                                            <tr>
                                                <td><code>${c.name}</code></td>
                                                <td><strong>${c.value}</strong></td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/cookie-demo?action=delete&name=${c.name}" 
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc muốn xóa cookie này không?')">
                                                        <i class="fa-solid fa-trash"></i> Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <div class="small text-muted mt-2">
                        <i class="fa-solid fa-lightbulb text-warning me-1"></i>
                        <em>Cookie <code>JSESSIONID</code> là mã định danh phiên làm việc do Tomcat Server tự sinh để duy trì <strong>HttpSession</strong>.</em>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
