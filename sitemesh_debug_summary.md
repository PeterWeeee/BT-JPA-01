# Tổng hợp Debug SiteMesh 3 trên Tomcat 11 (Jakarta EE 10)

## Vấn đề ban đầu
- Ứng dụng gặp lỗi khi cố gắng thêm giao diện (Profile) bằng jsp:include.
- User muốn chuyển sang dùng SiteMesh để quản lý giao diện.
- Sau khi thêm SiteMesh 3, các lỗi xảy ra:
  1. Trang login bị trắng (không hiện gì).
  2. Trang web báo lỗi TLD không tìm thấy (với sitemesh:3.3.0-RC1).
  3. Trang home sau khi đăng nhập admin tiếp tục bị trắng hoàn toàn.

## Quá trình điều tra và nguyên nhân
1. **Lỗi TLD (Tag Library Descriptor):** SiteMesh 3.3.0-RC1 không hỗ trợ khai báo taglib JSP (<%@ taglib prefix="sitemesh" %>). Thay vào đó, SiteMesh 3 tự động phân tích thẻ <sitemesh:write property="..."/> như một HTML tag ngay trong decorator. Việc khai báo dư taglib làm Tomcat báo lỗi không tìm thấy TLD.
2. **Lỗi exclude path sai:** File cấu hình sitemesh3.xml ban đầu exclude theo đường dẫn file JSP (/views/login.jsp) thay vì **URL Request** thực tế (/login). Do đó, trang login không được bỏ qua, dẫn đến SiteMesh cố đè layout vào gây trắng trang.
3. **Lỗi đặc thù trên Tomcat 11 (Trắng trang Home):** Tomcat 11 (Servlet 6.1) có cơ chế flush/commit response ngay khi thực thi lệnh orward() trong RequestDispatcher. Do đó, khi controller gọi eq.getRequestDispatcher(...).forward(), Tomcat lập tức đóng luồng trả về cho trình duyệt. SiteMesh filter chạy ở vòng ngoài không thể ghi thêm (decorator) vào luồng đã bị đóng, dẫn đến trang trắng tinh.

## Cách khắc phục đã áp dụng
1. **Nâng cấp/Sử dụng đúng bản SiteMesh hỗ trợ Jakarta EE (3.3.0-RC1)**: Bản cũ 3.2.3 sử dụng namespace javax.servlet, trong khi Tomcat 11 sử dụng jakarta.servlet, gây lỗi không nhận diện Filter.
2. **Bỏ khai báo JSP Taglib trong Decorator (main.jsp)**: Sử dụng trực tiếp thẻ <sitemesh:write> như thẻ HTML thông thường.
3. **Cấu hình web.xml chính xác**: Phải khai báo đủ cả 2 dispatcher REQUEST và FORWARD để bắt được các request nội bộ.
4. **THUỐC ĐẶC TRỊ - <dispatch-mode>include</dispatch-mode>**: Thêm thẻ này vào sitemesh3.xml. Thẻ này ép Tomcat dùng hàm include() thay vì orward(), giúp SiteMesh bọc giao diện kịp thời trước khi trang bị chốt (commit) và trả về.

## Kết quả
Sau khi áp dụng đầy đủ các cấu hình trên, dự án đã build thành công và khắc phục được 100% lỗi trắng trang trên Tomcat 11 với SiteMesh.

---
*Ghi chú: Theo yêu cầu mới nhất, chúng ta sẽ revert lại project về trạng thái ban đầu trên GitHub và tiếp tục phát triển chức năng Profile bằng phương pháp jsp:include thay vì SiteMesh.*
