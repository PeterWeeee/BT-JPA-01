<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Xac Nhan Email</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card p-4">
                    <div class="text-center mb-3">
                        <h4 class="fw-bold mt-2">Xac Nhan Email</h4>
                        <p class="text-muted small">
                            Chung toi da gui ma OTP 6 chu so den email <strong>${email}</strong>.<br>
                            Vui long kiem tra hop thu (ke ca thu muc spam).
                        </p>
                    </div>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 mb-3" role="alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <input type="hidden" name="email" value="${email}">
                        <input type="hidden" name="type" value="${type}">

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Ma OTP <span class="text-danger">*</span></label>
                            <input type="text"
                                   class="form-control form-control-lg text-center fw-bold"
                                   name="otp"
                                   placeholder="_ _ _ _ _ _"
                                   maxlength="6"
                                   autocomplete="one-time-code"
                                   required autofocus
                                   style="letter-spacing: 8px; font-size: 1.5rem;">
                            <div class="form-text text-center">Ma co hieu luc trong 10 phut</div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Kich Hoat Tai Khoan
                            </button>
                        </div>
                    </form>

                    <div class="text-center text-muted small">
                        Chua nhan duoc ma?
                        <a href="${pageContext.request.contextPath}/register">Dang ky lai</a>
                        hoac
                        <a href="${pageContext.request.contextPath}/login">Quay lai dang nhap</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
