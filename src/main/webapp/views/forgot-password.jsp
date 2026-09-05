<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quen Mat Khau</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card p-4">
                    <div class="text-center mb-3">
                        <h4 class="fw-bold mt-2">Quen Mat Khau</h4>
                        <p class="text-muted small">
                            Nhap dia chi email da dang ky. Chung toi se gui ma OTP de dat lai mat khau.
                        </p>
                    </div>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 mb-3" role="alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                        <div class="mb-4">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email"
                                   class="form-control"
                                   name="email"
                                   value="${email}"
                                   placeholder="name@example.com"
                                   required autofocus>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-warning fw-bold">
                                Gui Ma OTP
                            </button>
                        </div>
                    </form>

                    <div class="text-center text-muted small">
                        Nho mat khau roi?
                        <a href="${pageContext.request.contextPath}/login">Dang nhap tai day</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
