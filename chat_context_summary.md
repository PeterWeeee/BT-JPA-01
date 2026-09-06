# Bối cảnh & Tiến độ Dự án (BT-JPA-01)

## Mục tiêu
Xây dựng chức năng **Profile (Hồ sơ người dùng)** cho phép cập nhật: ullname, phone, và vatar (sử dụng form multipart/form-data).

## Công nghệ & Cách tiếp cận
- **Backend:** Java Servlet (Jakarta EE 10), JPA (Hibernate), SQL Server, Tomcat 11.
- **Frontend:** JSP, Bootstrap 5.
- **Kiến trúc giao diện:** Quyết định **giữ nguyên pattern <jsp:include>** cho header, topbar để đảm bảo an toàn và nhất quán với hệ thống cũ. Đã loại bỏ hoàn toàn ý tưởng áp dụng SiteMesh do gây xung đột lớn (lỗi trắng trang) trên Tomcat 11.

## Chi tiết các thay đổi đã thực hiện
1. **ProfileController.java (/profile)**:
   - Nhận GET: Tải thông tin user từ Session và hiển thị trang profile.
   - Nhận POST (@MultipartConfig): Xử lý upload ảnh đại diện (đổi tên file kèm UUID, lưu tại C:\upload\avatar). Cập nhật thông tin vào DB thông qua UserService (JPA) và làm mới đối tượng User trong Session.
2. **iews/profile.jsp**:
   - Giao diện cập nhật thông tin cá nhân (hỗ trợ preview ảnh tức thì bằng JavaScript).
   - Tích hợp layout thông qua <jsp:include page="/views/common/topbar.jsp"/>.
3. **iews/common/topbar.jsp**: 
   - Nâng cấp phần hiển thị thông tin người dùng góc phải thành Dropdown Menu.
   - Hiển thị Avatar thu nhỏ (nếu có) và thêm link chuyển đến trang Hồ sơ (/profile).
4. **Constant.java**: Thêm hằng số Path.PROFILE.
5. **sitemesh_debug_summary.md**: File đính kèm ghi lại toàn bộ kinh nghiệm và nguyên nhân lỗi Sitemesh 3 trên Tomcat 11 để lưu trữ tham khảo.

## Trạng thái hiện tại
- Code base an toàn, gọn gàng, không có rác của Sitemesh.
- Đã build Maven thành công.
- Code đã được Commit và sẵn sàng chạy thử.
