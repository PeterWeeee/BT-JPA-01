# BT-JPA-01: Quan Ly Danh Muc & Xac Thuc Nguoi Dung

Ung dung Web Java phat trien theo kien truc MVC 3 tang, su dung Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0), Hibernate ORM 7.x (JPA 3.0) va he quan tri co so du lieu Microsoft SQL Server.

---

## 1. Chuc Nang Chinh

### Quản lý Danh mục (Category CRUD)
- **Xem danh sách danh mục**: Hiển thị bảng danh sách danh mục, hình ảnh, tên và trạng thái (Hoạt động / Khóa).
- **Tìm kiếm danh mục**: Tìm kiếm danh mục theo từ khóa tên danh mục.
- **Thêm mới danh mục**: Nhập tên danh mục, nhập liên kết ảnh hoặc tải tệp ảnh trực tiếp từ máy tính. Có kiểm tra tính hợp lệ và thông báo trùng lặp.
- **Chỉnh sửa danh mục**: Cập nhật thông tin danh mục, hỗ trợ tải ảnh mới thay thế (tự động xóa ảnh cũ trên ổ đĩa).
- **Xóa danh mục**: Xóa bản ghi trong database bằng JPA `EntityManager.remove()`, hỗ trợ cascade xóa các thực thể con liên quan.

### Xác thực và Phân quyền (Authentication & Authorization)
- **Đăng ký tài khoản (`/register`)**: Tạo tài khoản mới, kiểm tra trùng lặp tên đăng nhập và email.
- **Đăng nhập (`/login`)**: Xác thực tài khoản, hỗ trợ tính năng ghi nhớ đăng nhập (Remember Me) qua Cookie.
- **Phân quyền theo vai trò**:
  - Admin (Role 1) -> Trang quản trị (`/admin/home`)
  - Manager (Role 2) -> Trang quản lý (`/manager/home`)
  - User (Role 3) -> Trang chủ (`/home`)
- **Đăng xuất (`/logout`)**: Hủy phiên làm việc (HttpSession) và chuyển hướng về trang đăng nhập.

---

## 2. Cong Nghe Su Dung

- **Ngôn ngữ**: Java 21 (LTS)
- **Chuẩn Web**: Jakarta EE 10 (Servlet API 6.1, JSP API 4.0, JSTL 3.0)
- **ORM / JPA**: Hibernate ORM 7.4.6.Final (Jakarta Persistence API 3.0+)
- **Cơ sở dữ liệu**: Microsoft SQL Server (Driver: `mssql-jdbc:12.8.1.jre11`)
- **Build Tool**: Apache Maven
- **Giao diện**: JSP, JSTL Core Tags, Bootstrap 5.3

---

## 3. Cau Truc Thu Muc

```text
BT-JPA-01
├── pom.xml
├── README.md
└── src
    └── main
        ├── java
        │   └── vn
        │       └── iotstar
        │           ├── connection
        │           │   └── DBConnection.java          # Ket noi JDBC
        │           ├── constant
        │           │   └── Constant.java              # Hang so he thong & thu muc C:\upload
        │           ├── controllers
        │           │   ├── AdminHomeController.java
        │           │   ├── CategoryController.java    # Dieu khien CRUD Category
        │           │   ├── DownloadImageController.java # Stream anh tu thu muc upload
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
        │           │       ├── CategoryDaoImpl.java   # DAO JPA xu ly Category
        │           │       └── UserDaoImpl.java       # DAO xu ly User
        │           ├── entity
        │           │   ├── Category.java              # Entity Category (@OneToMany Video)
        │           │   └── Video.java                 # Entity Video (@ManyToOne Category)
        │           ├── models
        │           │   ├── CategoryModel.java
        │           │   └── UserModel.java
        │           ├── repository
        │           │   ├── JpaConfig.java             # Quan ly EntityManagerFactory
        │           │   └── Test.java                  # Test runner JPA
        │           └── services
        │               ├── ICategoryService.java
        │               ├── IUserService.java
        │               └── impl
        │                   ├── CategoryServiceImpl.java
        │                   └── UserServiceImpl.java
        ├── resources
        │   └── META-INF
        │       └── persistence.xml                    # Cau hinh JPA Persistence Unit
        └── webapp
            ├── WEB-INF
            │   └── web.xml
            └── views
                ├── admin
                │   ├── category-add.jsp
                │   ├── category-edit.jsp
                │   └── category-list.jsp
                ├── common
                │   ├── header.jsp
                │   └── topbar.jsp
                ├── admin-home.jsp
                ├── home.jsp
                ├── login.jsp
                ├── manager-home.jsp
                ├── register.jsp
                └── error.jsp
```

---

## 4. Cau Hinh Co So Du Lieu

Chỉnh sửa thông số kết nối cơ sở dữ liệu trong file `src/main/resources/META-INF/persistence.xml`:

```xml
<persistence-unit name="jpa-hibernate-mysql">
    <class>vn.iotstar.entity.Category</class>
    <class>vn.iotstar.entity.Video</class>
    <properties>
        <property name="jakarta.persistence.jdbc.url"
            value="jdbc:sqlserver://localhost:1434;encrypt=true;trustServerCertificate=true;databaseName=webst4" />
        <property name="jakarta.persistence.jdbc.driver"
            value="com.microsoft.sqlserver.jdbc.SQLServerDriver" />
        <property name="jakarta.persistence.jdbc.user" value="sa" />
        <property name="jakarta.persistence.jdbc.password" value="123456" />

        <property name="hibernate.show_sql" value="true" />
        <property name="hibernate.format_sql" value="true" />
        <property name="hibernate.hbm2ddl.auto" value="update" />
        <property name="hibernate.dialect" value="org.hibernate.dialect.SQLServerDialect" />
    </properties>
</persistence-unit>
```

> Thư mục lưu trữ hình ảnh tải lên mặc định tại `C:\upload\category` (hoặc `C:\upload`). Ứng dụng sẽ tự động tạo thư mục này nếu chưa có.

---

## 5. Huong Dan Khoi Chay

1. **Import dự án**: Mở Eclipse / STS -> **File** -> **Import...** -> **Existing Maven Projects** -> Chọn thư mục `BT-JPA-01`.
2. **Khởi chạy máy chủ**: Chuột phải vào dự án `BT-JPA-01` -> **Run As** -> **Run on Server** (Apache Tomcat 10.1 hoặc Tomcat 11).
3. **Truy cập ứng dụng**: Mở trình duyệt tại địa chỉ:
   ```text
   http://localhost:8080/BT-JPA-01/
   ```

---

## 6. Danh Sach URL Chinh

| URL Pattern | Phương thức | Chức năng |
| :--- | :---: | :--- |
| `/login` | GET / POST | Đăng nhập hệ thống |
| `/register` | GET / POST | Đăng ký tài khoản |
| `/logout` | GET | Đăng xuất |
| `/home` | GET | Trang chủ |
| `/admin/home` | GET | Quản lý người dùng (Admin) |
| `/manager/home` | GET | Trang dành cho Manager |
| `/admin/categories` | GET | Danh sách danh mục |
| `/admin/category/add` | GET | Form thêm mới danh mục |
| `/admin/category/insert` | POST | Lưu danh mục mới & upload ảnh |
| `/admin/category/edit?id=...` | GET | Form chỉnh sửa danh mục |
| `/admin/category/update` | POST | Cập nhật thông tin danh mục & thay đổi ảnh |
| `/admin/category/delete?id=...` | GET | Xóa danh mục theo ID |
| `/image?fname=...` | GET | Tải và hiển thị hình ảnh từ thư mục upload |

---

## 7. Kiem Thu JPA Doc Lap

Chạy thử nghiệm kết nối JPA và tự động sinh bảng vào SQL Server mà không cần khởi động Tomcat:
- Trong Eclipse: Mở file `src/main/java/vn/iotstar/repository/Test.java` -> Chuột phải chọn **Run As** -> **Java Application**.
- Hoặc chạy qua dòng lệnh:
  ```bash
  mvn compile exec:java -Dexec.mainClass=vn.iotstar.repository.Test
  ```
Lớp này sẽ tự động kết nối đến SQL Server, sinh cấu trúc bảng `categories`, `Videos` và thêm bản ghi mẫu để kiểm tra.
