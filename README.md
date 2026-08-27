# BT-JPA-01: Ứng Dụng Quản Lý Danh Mục (CRUD) & Xác Thực Người Dùng với JPA 3.0, Servlet, JSP & SQL Server

Dự án mẫu thực hành môn Lập Trình Web (Kiến trúc MVC 3 lớp), sử dụng **Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0)**, **Hibernate ORM 7.x (JPA 3.0)** và hệ quản trị cơ sở dữ liệu **Microsoft SQL Server**.

---

## 📌 Các Chức Năng Chính

### 1. Quản lý Danh Mục Sản Phẩm (Category CRUD) bằng JPA
* **Xem danh sách danh mục**: Hiển thị bảng danh mục, hình ảnh đại diện, trạng thái (Hoạt động / Khóa), liên kết sửa và xóa.
* **Thêm mới danh mục**: Nhập tên danh mục, nhập URL ảnh hoặc tải tệp ảnh trực tiếp từ máy tính (multipart/form-data), chọn trạng thái.
* **Cập nhật danh mục**: Hiển thị thông tin và ảnh cũ, cho phép đổi tên, chọn ảnh mới thay thế (tự động xóa ảnh cũ trên ổ đĩa) hoặc giữ nguyên ảnh cũ.
* **Xóa danh mục**: Xóa bản ghi trong database bằng JPA EntityManager.remove(), có hộp thoại xác nhận trước khi xóa.
* **Liên kết Entity Video**: Thiết lập quan hệ hai chiều @OneToMany (Category $\leftrightarrow$ Video) và @ManyToOne (Video $\rightarrow$ Category).

### 2. Xác thực và Phân quyền người dùng (Authentication & Authorization)
* **Đăng ký tài khoản (/register)**: Tạo tài khoản mới với mã hóa mật khẩu, kiểm tra trùng lặp username/email.
* **Đăng nhập hệ thống (/login)**: Kiểm tra thông tin tài khoản, hỗ trợ tính năng **Ghi nhớ đăng nhập (Remember Me)** lưu qua Cookie.
* **Phân quyền theo vai trò (Role Routing)**:
  * Role ID = 1 (Admin) $\rightarrow$ Chuyển hướng tới **Admin Dashboard (/admin/home)**.
  * Role ID = 2 (Manager) $\rightarrow$ Chuyển hướng tới **Manager Dashboard (/manager/home)**.
  * Role ID = 3 (User) $\rightarrow$ Chuyển hướng tới **Trang chủ người dùng (/home)**.
* **Đăng xuất (/logout)**: Xóa Session và hủy Cookie đăng nhập.

---

## 🛠 Công Nghệ Sử Dụng

* **Ngôn ngữ**: Java 21+
* **Framework / Chuẩn**: Jakarta EE 10 (Servlet API 6.1, JSP API 4.0, JSTL 3.0)
* **ORM / JPA**: Hibernate ORM 7.4.6.Final (JPA 3.0 & Jakarta Persistence API 3.2)
* **Validation**: Hibernate Validator 9.0.1.Final, Glassfish Expressly 5.0 (Jakarta EL)
* **Cơ sở dữ liệu**: Microsoft SQL Server (Driver: mssql-jdbc 12.8.1)
* **Build Tool**: Apache Maven 3.9+
* **Giao diện**: JSP, JSTL Core Tags, Bootstrap 5.3, FontAwesome 6

---

## 📂 Cấu Trúc Dự Án (Package Hierarchy)

`	ext
BT-JPA-01
├── pom.xml
├── .gitignore
├── README.md
└── src
    └── main
        ├── java
        │   └── vn
        │       └── iotstar
        │           ├── connection
        │           │   └── DBConnection.java          # Kết nối JDBC dự phòng
        │           ├── constant
        │           │   └── Constant.java              # Hằng số đường dẫn & thư mục upload C:\upload
        │           ├── controllers
        │           │   ├── AdminHomeController.java
        │           │   ├── CategoryController.java    # Xử lý toàn bộ CRUD Category bằng JPA
        │           │   ├── CookieDemoController.java
        │           │   ├── DownloadImageController.java # Đọc và render ảnh từ C:\upload
        │           │   ├── HomeController.java
        │           │   ├── LoginController.java
        │           │   ├── LogoutController.java
        │           │   ├── ManagerHomeController.java
        │           │   ├── RegisterController.java
        │           │   └── WaitingController.java
        │           ├── dao
        │           │   ├── ICategoryDao.java
        │           │   ├── IUserDao.java
        │           │   └── impl
        │           │       ├── CategoryDaoImpl.java   # Triển khai DAO JPA qua EntityManager
        │           │       └── UserDaoImpl.java
        │           ├── entity
        │           │   ├── Category.java              # JPA Entity ánh xạ bảng 'categories'
        │           │   └── Video.java                 # JPA Entity ánh xạ bảng 'Videos'
        │           ├── models
        │           │   ├── CategoryModel.java
        │           │   └── UserModel.java
        │           ├── repository
        │           │   ├── JpaConfig.java             # Cấu hình EntityManagerFactory
        │           │   └── Test.java                  # Lớp chạy thử nghiệm JPA độc lập
        │           └── services
        │               ├── ICategoryService.java
        │               ├── IUserService.java
        │               └── impl
        │                   ├── CategoryServiceImpl.java
        │                   └── UserServiceImpl.java
        ├── resources
        │   └── META-INF
        │       └── persistence.xml                    # Cấu hình Persistence Unit 'jpa-hibernate-mysql'
        └── webapp
            ├── index.jsp
            ├── WEB-INF
            │   └── web.xml
            └── views
                ├── admin
                │   ├── category-add.jsp               # Giao diện Thêm mới Category
                │   ├── category-edit.jsp              # Giao diện Cập nhật Category
                │   └── category-list.jsp              # Giao diện Danh sách Category
                ├── common
                │   ├── header.jsp                     # Nhúng CSS & Bootstrap
                │   └── topbar.jsp                     # Thanh điều hướng Navbar
                ├── admin-home.jsp
                ├── home.jsp
                ├── login.jsp
                ├── manager-home.jsp
                ├── register.jsp
                └── error.jsp
`

---

## ⚙️ Hướng Dẫn Cấu Hình Cơ Sở Dữ Liệu

Mở file src/main/resources/META-INF/persistence.xml và điều chỉnh thông số kết nối phù hợp với máy của bạn:

`xml
<persistence-unit name=jpa-hibernate-mysql>
    <class>vn.iotstar.entity.Category</class>
    <class>vn.iotstar.entity.Video</class>
    <properties>
        <!-- Cấu hình JDBC URL, Cổng kết nối (mặc định 1433 hoặc 1434) và tên Database -->
        <property name=jakarta.persistence.jdbc.url
            value=jdbc:sqlserver://localhost:1434;encrypt=true;trustServerCertificate=true;databaseName=webst4 />
        <property name=jakarta.persistence.jdbc.driver
            value=com.microsoft.sqlserver.jdbc.SQLServerDriver />
        <property name=jakarta.persistence.jdbc.user value=sa />
        <property name=jakarta.persistence.jdbc.password value=123456 />

        <property name=hibernate.show_sql value=true />
        <property name=hibernate.format_sql value=true />
        
        <!-- Tự động tạo và cập nhật bảng trong Database -->
        <property name=hibernate.hbm2ddl.auto value=update />
        <property name=hibernate.dialect value=org.hibernate.dialect.SQLServerDialect />
    </properties>
</persistence-unit>
`

> **Lưu ý về thư mục lưu ảnh**: Mặc định ứng dụng lưu ảnh tải lên tại C:\upload (được cấu hình trong n.iotstar.constant.Constant.DIR). Thư mục này sẽ được tự động tạo nếu chưa có.

---

## 🚀 Hướng Dẫn Sử Dụng Ứng Dụng Web

### 1. Khởi chạy trên Eclipse / Spring Tool Suite (STS)
1. Import dự án: **File** $\rightarrow$ **Import...** $\rightarrow$ **Existing Maven Projects** $\rightarrow$ Chọn thư mục BT-JPA-01.
2. Chuột phải vào project BT-JPA-01 $\rightarrow$ **Run As** $\rightarrow$ **Run on Server** (Chọn **Apache Tomcat 10.1** hoặc **Tomcat 11**).
3. Sau khi Server khởi động thành công, mở trình duyệt web truy cập:
   `	ext
   http://localhost:8080/BT-JPA-01/
   `

### 2. Các Đường Dẫn (URL Endpoints) Chính

| URL Pattern | Phương Thức | Mục Đích |
| :--- | :---: | :--- |
| /login | GET / POST | Trang đăng nhập hệ thống |
| /register | GET / POST | Trang đăng ký tài khoản người dùng |
| /logout | GET | Đăng xuất khỏi hệ thống |
| /home | GET | Trang chủ dành cho người dùng thường (Role = 3) |
| /admin/home | GET | Dashboard quản trị viên (Role = 1) |
| /manager/home | GET | Dashboard quản lý (Role = 2) |
| **/admin/categories** | GET | **Xem danh sách danh mục (JPA)** |
| **/admin/category/add** | GET | **Mở form thêm mới danh mục** |
| **/admin/category/insert** | POST | **Lưu danh mục mới & upload ảnh vào C:\upload** |
| **/admin/category/edit?id=...** | GET | **Mở form chỉnh sửa danh mục theo ID** |
| **/admin/category/update** | POST | **Cập nhật thông tin danh mục & thay đổi ảnh** |
| **/admin/category/delete?id=...** | GET | **Xóa danh mục theo ID khỏi Database** |
| /image?fname=... | GET | Servlet tải và hiển thị hình ảnh từ thư mục upload |

---

## 🧪 Kiểm Thử JPA Độc Lập (Test Runner)

Bạn có thể chạy thử nghiệm kết nối JPA và tự động sinh bảng vào SQL Server mà không cần bật Tomcat:
* Trong Eclipse: Mở file src/main/java/vn/iotstar/repository/Test.java $\rightarrow$ Chuột phải chọn **Run As** $\rightarrow$ **Java Application**.
* Hoặc chạy qua dòng lệnh Terminal/PowerShell:
  `ash
  mvn compile exec:java -Dexec.mainClass=vn.iotstar.repository.Test
  `
Lớp này sẽ tự động kết nối đến SQL Server, sinh cấu trúc bảng categories, Videos và thêm 2 bản ghi mẫu để kiểm tra.
