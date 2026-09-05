<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Them San Pham</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="fw-bold mb-0">Them San Pham Moi</h4>
                        <a href="${pageContext.request.contextPath}/admin/products"
                           class="btn btn-sm btn-outline-secondary">Danh sach</a>
                    </div>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 mb-3">${alert}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/product/insert"
                          method="post" enctype="multipart/form-data">

                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label">Ten san pham <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="productName"
                                       value="${productName}" placeholder="Nhap ten san pham" required autofocus>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Danh muc <span class="text-danger">*</span></label>
                                <select class="form-select" name="categoryId" required>
                                    <option value="">-- Chon danh muc --</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.categoryId}">${cat.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Gia (VND)</label>
                                <input type="number" class="form-control" name="price"
                                       min="0" step="1000" placeholder="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">So luong</label>
                                <input type="number" class="form-control" name="quantity"
                                       min="0" value="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Trang thai</label>
                                <select class="form-select" name="status">
                                    <option value="1">Hien thi</option>
                                    <option value="0">An</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mo ta</label>
                            <textarea class="form-control" name="description" rows="4"
                                      placeholder="Nhap mo ta san pham..."></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Anh san pham (tai len)</label>
                                <input type="file" class="form-control" name="images1"
                                       accept="image/*" onchange="previewImage(this)">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Hoac URL anh</label>
                                <input type="text" class="form-control" name="images"
                                       placeholder="https://...">
                            </div>
                        </div>

                        <div class="mb-3" id="imagePreviewBox" style="display:none;">
                            <img id="imagePreview" src="" alt="Preview"
                                 style="max-height:200px;border-radius:6px;border:1px solid #e2e8f0;">
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">Luu San Pham</button>
                            <a href="${pageContext.request.contextPath}/admin/products"
                               class="btn btn-outline-secondary">Huy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            var box = document.getElementById('imagePreviewBox');
            var img = document.getElementById('imagePreview');
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    img.src = e.target.result;
                    box.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
