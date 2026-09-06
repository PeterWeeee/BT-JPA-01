<%@ tag description="Main Layout Tag" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="head" fragment="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${title}</title>
    <!-- CSS dùng chung -->
    <jsp:include page="/views/common/header.jsp" />
    
    <!-- Cho phép trang con thêm CSS/JS vào phần head -->
    <jsp:invoke fragment="head"/>
</head>
<body>
    <!-- Navbar chung -->
    <jsp:include page="/views/common/topbar.jsp" />

    <!-- Nội dung chính của trang con sẽ nằm ở đây -->
    <main>
        <jsp:doBody/>
    </main>

    <!-- JS Bootstrap dùng chung -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Script khởi tạo Validation chung cho toàn bộ Form có class needs-validation -->
    <script>
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>
