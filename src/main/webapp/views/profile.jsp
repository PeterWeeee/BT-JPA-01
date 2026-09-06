<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Hồ Sơ Của Tôi</title>
    <jsp:include page="/views/common/header.jsp" />
    <style>
        .avatar-circle {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #e2e8f0;
        }
        .avatar-placeholder {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #94a3b8;
            border: 3px dashed #cbd5e1;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/views/common/topbar.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            
            <div class="d-flex align-items-center gap-3 mb-4">
                <i class="bi bi-person-circle fs-3 text-primary"></i>
                <div>
                    <h3 class="fw-bold mb-0">Hồ Sơ Của Tôi</h3>
                    <p class="text-muted small mb-0">Cập nhật thông tin cá nhân</p>
                </div>
            </div>

            <c:if test="${param.success eq '1'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>
                    <strong>Thành công!</strong> Thông tin cá nhân đã được cập nhật.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card p-4 shadow-sm border-0">
                <div class="text-center mb-4">
                    <c:choose>
                        <c:when test="${not empty profileUser.avatar and profileUser.avatar ne 'default-avatar.png'}">
                            <img id="avatarPreview"
                                 src="${pageContext.request.contextPath}/download-image?filename=avatar/${profileUser.avatar}"
                                 alt="Avatar"
                                 class="avatar-circle">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-placeholder mx-auto" id="avatarPlaceholder">
                                <i class="bi bi-person"></i>
                            </div>
                            <img id="avatarPreview" src="" alt="Preview" class="avatar-circle d-none">
                        </c:otherwise>
                    </c:choose>
                    <div class="mt-2 text-muted small">Ảnh đại diện</div>
                </div>

                <form action="${pageContext.request.contextPath}/profile"
                      method="post"
                      enctype="multipart/form-data"
                      novalidate
                      class="needs-validation">

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label class="form-label fw-semibold">Tên đăng nhập</label>
                            <input type="text" class="form-control bg-light" value="${profileUser.userName}" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email</label>
                            <input type="text" class="form-control bg-light" value="${profileUser.email}" readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold">
                            Họ và tên <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="fullname" name="fullname" 
                               value="${profileUser.fullName}" required maxlength="100">
                        <div class="invalid-feedback">Vui lòng nhập họ và tên.</div>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               value="${profileUser.phone}" maxlength="15">
                    </div>

                    <div class="mb-4">
                        <label for="avatarFile" class="form-label fw-semibold">Thay đổi ảnh đại diện</label>
                        <input type="file" class="form-control" id="avatarFile" name="avatarFile" 
                               accept=".jpg,.jpeg,.png,.gif,.webp" onchange="previewAvatar(this)">
                        <div class="form-text">Bỏ trống nếu không muốn thay đổi (tối đa 5MB).</div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">Hủy bỏ</a>
                    </div>
                </form>
            </div>
            
            <div class="card p-3 mt-3 bg-white border-0 shadow-sm text-muted small">
                <div class="row">
                    <div class="col-sm-6 mb-2 mb-sm-0">
                        <i class="bi bi-calendar me-1"></i> Ngày tạo: <strong>${profileUser.createdDate}</strong>
                    </div>
                    <div class="col-sm-6 text-sm-end">
                        <i class="bi bi-shield-check me-1"></i> Quyền hạn: 
                        <strong>
                            <c:choose>
                                <c:when test="${profileUser.roleid == 1}">Quản trị viên (Admin)</c:when>
                                <c:when test="${profileUser.roleid == 2}">Người quản lý (Manager)</c:when>
                                <c:otherwise>Khách hàng (User)</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
function previewAvatar(input) {
    if (input.files && input.files[0]) {
        var file = input.files[0];
        if (file.size > 5 * 1024 * 1024) {
            alert('File quá lớn! Vui lòng chọn file dưới 5MB.');
            input.value = '';
            return;
        }
        var reader = new FileReader();
        reader.onload = function(e) {
            var preview = document.getElementById('avatarPreview');
            var placeholder = document.getElementById('avatarPlaceholder');
            preview.src = e.target.result;
            preview.classList.remove('d-none');
            if (placeholder) {
                placeholder.classList.add('d-none');
            }
        };
        reader.readAsDataURL(file);
    }
}

(function() {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>

</body>
</html>