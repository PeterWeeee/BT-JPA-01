# BT-JPA-01: Quan Ly Danh Muc, San Pham & Xac Thuc Nguoi Dung (OTP Email)

Ung dung Web Java phat trien theo kien truc MVC 3 tang, su dung Jakarta EE 10
(Servlet 6.1, JSP 4.0, JSTL 3.0), Hibernate ORM 7.x (JPA 3.0), Jakarta Mail va Microsoft SQL Server.

---

## 1. Chuc Nang Chinh

### Quan ly Danh muc (Category CRUD)

| Chuc nang | Mo ta |
| :--- | :--- |
| Xem danh sach | Hien thi bang danh sach danh muc, hinh anh, ten va trang thai |
| Tim kiem | Tim kiem theo tu khoa ten danh muc |
| Them moi | Nhap ten, lien ket anh hoac upload anh; kiem tra trung lap |
| Chinh sua | Cap nhat thong tin, thay anh moi (tu dong xoa anh cu tren o dia) |
| Xoa | Xoa ban ghi, cascade xoa Video va Product con lien quan |

### Quan ly San pham (Product CRUD & Hien thi)

| Chuc nang | Mo ta |
| :--- | :--- |
| Quan he 1-N | Entity Product lien ket ManyToOne voi Category (@JoinColumn CategoryId) |
| Admin CRUD | Them, sua, xoa, tim kiem san pham kem upload anh (luu tai C:\upload\product) |
| 10 SP moi nhat | Hien thi danh sach 10 san pham moi nhat len trang chu (/home) |
| Phan trang (/product) | Hien thi tat ca san pham duoc phan trang 6 san pham/trang, ho tro chuyen trang va tim kiem |
| Chi tiet san pham | Xem thong tin chi tiet 1 san pham khi click tu trang chu hoac trang /product (/product/detail?id=...) |

### Xac thuc, Phan quyen & OTP qua Email

| Tinh nang | Mo ta |
| :--- | :--- |
| Dang ky & Kich hoat OTP | Dang ky tai khoan voi status=0 (chua kich hoat); he thong tu dong tao ma OTP 6 so va gui qua Gmail SMTP. Nguoi dung nhap ma OTP tai /verify-otp trong 10 phut de kich hoat tai khoan (status=1) |
| Dang nhap | Xac thuc tai khoan; kiem tra trang thai kich hoat (status != 0); ho tro Remember Me qua Cookie (24h) |
| Quen & Dat lai mat khau | Nhap email tai /forgot-password de nhan ma OTP qua email; nhap ma OTP va mat khau moi tai /reset-password de cap nhat mat khau |
| Session & Phan quyen | Luu UserModel phia server (30 phut); AuthFilter chan toan bo /admin/* (chi Admin va Manager duoc truy cap) |
| Dang xuat | Huy session (session.invalidate()), chuyen ve trang dang nhap |

**Phan quyen theo vai tro:**

| Role | Ten | Quyen truy cap |
| :---: | :--- | :--- |
| 1 | Admin | /admin/home, toan bo /admin/* (Category & Product CRUD, User) |
| 2 | Manager | /manager/home, toan bo /admin/* |
| 3 | User | /home, /product, /product/detail, khong vao duoc /admin/* |

---

## 2. Cong Nghe Su Dung

| Thanh phan | Phien ban / Chi tiet |
| :--- | :--- |
| Ngon ngu | Java 21 (LTS) |
| Chuan Web | Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0) |
| ORM / JPA | Hibernate ORM 7.4.6.Final (Jakarta Persistence 3.0+) |
| Dich vu Email | Jakarta Mail (angus-mail 2.0.3) qua Gmail SMTP |
| Co so du lieu | Microsoft SQL Server |
| JDBC Driver | mssql-jdbc 12.8.1.jre11 |
| Build Tool | Apache Maven |
| Giao dien | JSP, JSTL Core Tags, Bootstrap 5.3 |

---

## 3. Cau Truc Thu Muc

```
BT-JPA-01/
├── database.sql                    (Script tao CSDL SQL Server webst4 va du lieu mau)
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/vn/iotstar/
        │   ├── config/
        │   │   └── JPAConfig.java                 (Singleton EntityManagerFactory)
        │   ├── constant/
        │   │   └── Constant.java                  (Hang so he thong, duong dan C:\upload)
        │   ├── controllers/
        │   │   ├── AdminHomeController.java
        │   │   ├── CategoryController.java         (CRUD Category)
        │   │   ├── DownloadImageController.java    (Phuc vu anh category va product)
        │   │   ├── ForgotPasswordController.java   (Gui OTP quen mat khau)
        │   │   ├── HomeController.java             (Trang chu: top 10 SP moi nhat)
        │   │   ├── LoginController.java            (Dang nhap)
        │   │   ├── LogoutController.java           (Dang xuat)
        │   │   ├── ManagerHomeController.java
        │   │   ├── OtpVerifyController.java        (Xac minh OTP kich hoat tai khoan)
        │   │   ├── ProductController.java          (Admin CRUD Product)
        │   │   ├── ProductDetailController.java    (Chi tiet 1 san pham)
        │   │   ├── ProductListController.java      (Danh sach SP phan trang 6 SP/trang)
        │   │   ├── RegisterController.java         (Dang ky tai khoan)
        │   │   ├── ResetPasswordController.java    (Dat lai mat khau qua OTP)
        │   │   └── WaitingController.java
        │   ├── dao/
        │   │   ├── ICategoryDao.java
        │   │   ├── IProductDao.java
        │   │   ├── IUserDao.java
        │   │   └── impl/
        │   │       ├── CategoryDaoImpl.java        (DAO JPA - Category)
        │   │       ├── ProductDaoImpl.java         (DAO JPA - Product)
        │   │       └── UserDaoImpl.java            (DAO JPA - User)
        │   ├── entity/
        │   │   ├── Category.java                  (JPA Entity, 1-N voi Video & Product)
        │   │   ├── Product.java                   (JPA Entity, N-1 voi Category)
        │   │   ├── Video.java                     (JPA Entity, N-1 voi Category)
        │   │   └── User.java                      (JPA Entity, luu OTP va trang thai kich hoat)
        │   ├── filters/
        │   │   └── AuthFilter.java                (Phan quyen tap trung cho /admin/*)
        │   ├── models/
        │   │   ├── CategoryModel.java
        │   │   └── UserModel.java                 (Ke thua User de tuong thich nguoc)
        │   ├── services/
        │   │   ├── ICategoryService.java
        │   │   ├── IProductService.java
        │   │   ├── IUserService.java
        │   │   └── impl/
        │   │       ├── CategoryServiceImpl.java
        │   │       ├── ProductServiceImpl.java
        │   │       └── UserServiceImpl.java
        │   └── utils/
        │       └── EmailUtil.java                 (Tien ich gui mail OTP qua Gmail SMTP)
        ├── resources/
        │   ├── META-INF/
        │   │   └── persistence.xml                (Cau hinh JPA: jpa-hibernate-sqlserver)
        │   └── email.properties                   (Cau hinh SMTP Gmail gui mail)
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml
            └── views/
                ├── admin/
                │   ├── category-add.jsp
                │   ├── category-edit.jsp
                │   ├── category-list.jsp
                │   ├── product-add.jsp
                │   ├── product-edit.jsp
                │   └── product-list.jsp
                ├── common/
                │   ├── header.jsp
                │   └── topbar.jsp
                ├── admin-home.jsp
                ├── error.jsp
                ├── forgot-password.jsp
                ├── home.jsp
                ├── login.jsp
                ├── manager-home.jsp
                ├── product.jsp
                ├── product-detail.jsp
                ├── register.jsp
                ├── reset-password.jsp
                └── verify-otp.jsp
```

---

## 4. Cau Hinh Co So Du Lieu & Email

### Cau hinh persistence.xml

Toan bo cac Entity (`Category`, `Video`, `User`, `Product`) duoc quan ly thuan JPA:

```xml
<persistence-unit name="jpa-hibernate-sqlserver">
    <class>vn.iotstar.entity.Category</class>
    <class>vn.iotstar.entity.Video</class>
    <class>vn.iotstar.entity.User</class>
    <class>vn.iotstar.entity.Product</class>
    <properties>
        <property name="jakarta.persistence.jdbc.url"
                  value="jdbc:sqlserver://localhost:1434;encrypt=true;
                         trustServerCertificate=true;databaseName=webst4" />
        <property name="jakarta.persistence.jdbc.driver"
                  value="com.microsoft.sqlserver.jdbc.SQLServerDriver" />
        <property name="jakarta.persistence.jdbc.user"     value="sa" />
        <property name="jakarta.persistence.jdbc.password" value="123456" />
        <property name="hibernate.show_sql"      value="true" />
        <property name="hibernate.format_sql"    value="true" />
        <property name="hibernate.hbm2ddl.auto"  value="update" />
        <property name="hibernate.dialect"
                  value="org.hibernate.dialect.SQLServerDialect" />
    </properties>
</persistence-unit>
```

### Cau hinh email.properties

Dung cho chuc nang gui OTP qua email:

```properties
mail.smtp.host=smtp.gmail.com
mail.smtp.port=587
mail.smtp.auth=true
mail.smtp.starttls.enable=true

mail.from=NguyenTT162.4@gmail.com
mail.password=csbo rfmp bvqm qnbx
mail.from.name=IoTStar Shop
```

> Thu muc luu anh upload: `C:\upload\category` va `C:\upload\product` (tu dong tao neu chua co).

---

## 5. Huong Dan Khoi Chay
 
0. **Co so du lieu**: Mo file `database.sql` trong SQL Server Management Studio (SSMS) va thuc thi (Execute) de khoi tao database `webst4` va nap du lieu mau.
1. **Import**: Eclipse / STS -> File -> Import -> Existing Maven Projects -> chon thu muc `BT-JPA-01`.
2. **Chay**: Chuot phai du an -> Run As -> Run on Server (Tomcat 10.1 hoac Tomcat 11).
3. **Truy cap**: `http://localhost:8080/BT-JPA-01/`

**Tai khoan mac dinh (fallback khi chua co DB):**

| Username | Password | Role |
| :---: | :---: | :--- |
| admin | 123 | Admin (Role 1) |
| manager | 123 | Manager (Role 2) |
| user | 123 | User (Role 3) |

---

## 6. Danh Sach URL

| URL | Phuong thuc | Quyen | Chuc nang |
| :--- | :---: | :--- | :--- |
| /home | GET | Tat ca | Trang chu (Hien thi 10 san pham moi nhat) |
| /product | GET | Tat ca | Danh sach san pham phan trang (6 SP/trang) |
| /product/detail?id=N | GET | Tat ca | Chi tiet 01 san pham |
| /login | GET, POST | Tat ca | Dang nhap (Kiem tra status kich hoat) |
| /register | GET, POST | Tat ca | Dang ky tai khoan & gui ma OTP |
| /verify-otp | GET, POST | Tat ca | Xac minh OTP kich hoat tai khoan |
| /forgot-password | GET, POST | Tat ca | Nhap email nhan OTP dat lai mat khau |
| /reset-password | GET, POST | Tat ca | Nhap OTP va mat khau moi |
| /logout | GET | Tat ca | Dang xuat |
| /image?fname=... | GET | Tat ca | Hien thi anh category (/image?type=product&fname=... cho san pham) |
| /admin/home | GET | Admin | Trang chu Admin |
| /manager/home | GET | Manager | Trang chu Manager |
| /admin/categories | GET | Admin, Manager | Danh sach danh muc |
| /admin/category/add | GET | Admin, Manager | Form them danh muc |
| /admin/category/insert | POST | Admin, Manager | Luu danh muc moi |
| /admin/category/edit?id=N | GET | Admin, Manager | Form chinh sua danh muc |
| /admin/category/update | POST | Admin, Manager | Luu cap nhat danh muc |
| /admin/category/delete?id=N | GET | Admin, Manager | Xoa danh muc |
| /admin/products | GET | Admin, Manager | Danh sach san pham (tim kiem) |
| /admin/product/add | GET | Admin, Manager | Form them san pham |
| /admin/product/insert | POST | Admin, Manager | Luu san pham moi |
| /admin/product/edit?id=N | GET | Admin, Manager | Form chinh sua san pham |
| /admin/product/update | POST | Admin, Manager | Luu cap nhat san pham |
| /admin/product/delete?id=N | GET | Admin, Manager | Xoa san pham |

---

## 7. Kiem Thu JPA Doc Lap

Kiem tra ket noi JPA va tu dong tao bang trong SQL Server ma khong can Tomcat:

```bash
mvn compile exec:java -Dexec.mainClass=vn.iotstar.repository.Test
```

Hoac trong Eclipse: mo `Test.java` -> Chuot phai -> Run As -> Java Application.