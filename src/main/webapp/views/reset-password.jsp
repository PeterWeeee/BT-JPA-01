<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Dat Lai Mat Khau</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card p-4">
                    <div class="text-center mb-3">
                        <h4 class="fw-bold mt-2">Dat Lai Mat Khau</h4>
                        <p class="text-muted small">
                            Nhap ma OTP da duoc gui den <strong>${email}</strong>
                            va mat khau moi cua ban.
                        </p>
                    </div>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 mb-3" role="alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/reset-password" method="post">
                        <input type="hidden" name="email" value="${email}">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ma OTP <span class="text-danger">*</span></label>
                            <input type="text"
                                   class="form-control text-center fw-bold"
                                   name="otp"
                                   placeholder="_ _ _ _ _ _"
                                   maxlength="6"
                                   autocomplete="one-time-code"
                                   required autofocus
                                   style="letter-spacing: 6px; font-size: 1.3rem;">
                            <div class="form-text text-center">Ma co hieu luc trong 10 phut</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mat khau moi <span class="text-danger">*</span></label>
                            <input type="password"
                                   class="form-control"
                                   name="newPassword"
                                   placeholder="It nhat 6 ky tu"
                                   minlength="6"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Xac nhan mat khau <span class="text-danger">*</span></label>
                            <input type="password"
                                   class="form-control"
                                   name="confirmPassword"
                                   placeholder="Nhap lai mat khau"
                                   minlength="6"
                                   required>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary">
                                Dat Lai Mat Khau
                            </button>
                        </div>
                    </form>

                    <div class="text-center text-muted small">
                        <a href="${pageContext.request.contextPath}/forgot-password">Gui lai ma OTP</a>
                        &nbsp;|&nbsp;
                        <a href="${pageContext.request.contextPath}/login">Dang nhap</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
