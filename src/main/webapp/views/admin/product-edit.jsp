<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Sua San Pham</title>
    <jsp:include page="/views/common/header.jsp" />
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp" />

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="fw-bold mb-0">Sua San Pham</h4>
                        <a href="${pageContext.request.contextPath}/admin/products"
                           class="btn btn-sm btn-outline-secondary">Danh sach</a>
                    </div>

                    <c:if test="${alert != null}">
                        <div class="alert alert-danger py-2 mb-3">${alert}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/product/update"
                          method="post" enctype="multipart/form-data">

                        <input type="hidden" name="productId" value="${product.productId}">
                        <input type="hidden" name="images" value="${product.images}">

                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label">Ten san pham <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="productName"
                                       value="${product.productName}" required autofocus>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Danh muc <span class="text-danger">*</span></label>
                                <select class="form-select" name="categoryId" required>
                                    <option value="">-- Chon danh muc --</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.categoryId}"
                                            <c:if test="${product.category != null and product.category.categoryId == cat.categoryId}">selected</c:if>>
                                            ${cat.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Gia (VND)</label>
                                <input type="number" class="form-control" name="price"
                                       min="0" step="1000" value="${product.price}">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">So luong</label>
                                <input type="number" class="form-control" name="quantity"
                                       min="0" value="${product.quantity}">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Trang thai</label>
                                <select class="form-select" name="status">
                                    <option value="1" ${product.status == 1 ? 'selected' : ''}>Hien thi</option>
                                    <option value="0" ${product.status == 0 ? 'selected' : ''}>An</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mo ta</label>
                            <textarea class="form-control" name="description" rows="4">${product.description}</textarea>
                        </div>

                        <c:if test="${not empty product.images}">
                            <div class="mb-3">
                                <label class="form-label text-muted">Anh hien tai:</label><br>
                                <c:choose>
                                    <c:when test="${not product.images.startsWith('http') and product.images ne 'avatar.png'}">
                                        <img src="${pageContext.request.contextPath}/download-image?filename=product/${product.images}"
                                             style="max-height:120px;border-radius:6px;border:1px solid #e2e8f0;" alt="">
                                    </c:when>
                                    <c:when test="${product.images.startsWith('http')}">
                                        <img src="${product.images}" style="max-height:120px;border-radius:6px;" alt="">
                                    </c:when>
                                </c:choose>
                            </div>
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label">Thay anh moi (de trong neu giu anh cu)</label>
                            <input type="file" class="form-control" name="images1"
                                   accept="image/*" onchange="previewImage(this)">
                        </div>

                        <div class="mb-3" id="imagePreviewBox" style="display:none;">
                            <img id="imagePreview" src="" alt="Preview"
                                 style="max-height:200px;border-radius:6px;border:1px solid #e2e8f0;">
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-warning fw-bold">Cap Nhat</button>
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
