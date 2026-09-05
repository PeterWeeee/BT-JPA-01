# BT-JPA-01: Quan Ly Danh Muc & Xac Thuc Nguoi Dung

Ung dung Web Java phat trien theo kien truc MVC 3 tang, su dung Jakarta EE 10
(Servlet 6.1, JSP 4.0, JSTL 3.0), Hibernate ORM 7.x (JPA 3.0) va Microsoft SQL Server.

---

## 1. Chuc Nang Chinh

### Quan ly Danh muc (Category CRUD)

| Chuc nang | Mo ta |
| :--- | :--- |
| Xem danh sach | Hien thi bang danh sach danh muc, hinh anh, ten va trang thai |
| Tim kiem | Tim kiem theo tu khoa ten danh muc |
| Them moi | Nhap ten, lien ket anh hoac upload anh; kiem tra trung lap |
| Chinh sua | Cap nhat thong tin, thay anh moi (tu dong xoa anh cu tren o dia) |
| Xoa | Xoa ban ghi, cascade xoa Video con lien quan |

### Xac thuc & Phan quyen

| Tinh nang | Mo ta |
| :--- | :--- |
| Dang ky | Tao tai khoan moi, kiem tra trung lap username va email |
| Dang nhap | Xac thuc tai khoan; ho tro Remember Me qua Cookie (luu username, 24h) |
| Session | Luu UserModel phia server (song 30 phut); moi request deu kiem tra session de biet quyen |
| Phan quyen | AuthFilter chan toan bo /admin/*; Admin va Manager duoc vao, User bi tu choi |
| Dang xuat | Huy session (session.invalidate()), chuyen ve trang dang nhap |

**Phan quyen theo vai tro:**

| Role | Ten | Quyen truy cap |
| :---: | :--- | :--- |
| 1 | Admin | /admin/home, toan bo /admin/* |
| 2 | Manager | /manager/home, toan bo /admin/* |
| 3 | User | /home, khong vao duoc /admin/* |

---

## 2. Cong Nghe Su Dung

| Thanh phan | Phien ban / Chi tiet |
| :--- | :--- |
| Ngon ngu | Java 21 (LTS) |
| Chuan Web | Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0) |
| ORM / JPA | Hibernate ORM 7.4.6.Final (Jakarta Persistence 3.0+) |
| Co so du lieu | Microsoft SQL Server |
| JDBC Driver | mssql-jdbc 12.8.1.jre11 |
| Build Tool | Apache Maven |
| Giao dien | JSP, JSTL Core Tags, Bootstrap 5.3 |

---

## 3. Cau Truc Thu Muc

```
BT-JPA-01/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/vn/iotstar/
        │   ├── config/
        │   │   └── JPAConfig.java              (Singleton EntityManagerFactory)
        │   ├── constant/
        │   │   └── Constant.java               (Hang so he thong, duong dan C:\upload)
        │   ├── controllers/
        │   │   ├── AdminHomeController.java
        │   │   ├── CategoryController.java      (CRUD Category)
        │   │   ├── DownloadImageController.java
        │   │   ├── HomeController.java
        │   │   ├── LoginController.java
        │   │   ├── LogoutController.java
        │   │   ├── ManagerHomeController.java
        │   │   ├── RegisterController.java
        │   │   └── WaitingController.java
        │   ├── dao/
        │   │   ├── ICategoryDao.java
        │   │   ├── IUserDao.java
        │   │   └── impl/
        │   │       ├── CategoryDaoImpl.java     (DAO JPA - Category)
        │   │       └── UserDaoImpl.java         (DAO JPA - User)
        │   ├── entity/
        │   │   ├── Category.java               (JPA Entity, @OneToMany Video)
        │   │   ├── Video.java                  (JPA Entity, @ManyToOne Category)
        │   │   └── User.java                   (JPA Entity, bang users)
        │   ├── filters/
        │   │   └── AuthFilter.java             (Phan quyen tap trung cho /admin/*)
        │   ├── models/
        │   │   ├── CategoryModel.java
        │   │   └── UserModel.java              (Ke thua User de tuong thich nguoc)
        │   ├── repository/
        │   │   └── Test.java                   (Test runner JPA doc lap ca 3 entity)
        │   └── services/
        │       ├── ICategoryService.java
        │       ├── IUserService.java
        │       └── impl/
        │           ├── CategoryServiceImpl.java
        │           └── UserServiceImpl.java
        ├── resources/
        │   └── META-INF/
        │       └── persistence.xml             (Cau hinh JPA: jpa-hibernate-sqlserver)
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml
            └── views/
                ├── admin/
                │   ├── category-add.jsp
                │   ├── category-edit.jsp
                │   └── category-list.jsp
                ├── common/
                │   ├── header.jsp
                │   └── topbar.jsp
                ├── admin-home.jsp
                ├── error.jsp
                ├── home.jsp
                ├── login.jsp
                ├── manager-home.jsp
                └── register.jsp
```

---

## 4. Cau Hinh Co So Du Lieu (Thuan JPA)

Toan bo project da duoc hop nhat 100% sang **JPA / Hibernate ORM**, xoa bo hoan toan JDBC thuan va CSDL phu de tranh xung dot:

| Phan | Co che | Database | Port |
| :--- | :--- | :---: | :---: |
| Toan bo (Category, Video, User) | JPA / Hibernate (persistence.xml) | webst4 | 1434 |

### Cau hinh persistence.xml

```xml
<persistence-unit name="jpa-hibernate-sqlserver">
    <class>vn.iotstar.entity.Category</class>
    <class>vn.iotstar.entity.Video</class>
    <class>vn.iotstar.entity.User</class>
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

> Thu muc luu anh upload: `C:\upload\category` (tu dong tao neu chua co).

---

## 5. Huong Dan Khoi Chay

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
| /login | GET, POST | Tat ca | Dang nhap |
| /register | GET, POST | Tat ca | Dang ky tai khoan |
| /logout | GET | Tat ca | Dang xuat |
| /home | GET | Tat ca | Trang chu |
| /admin/home | GET | Admin | Quan ly nguoi dung |
| /manager/home | GET | Manager | Trang danh cho Manager |
| /admin/categories | GET | Admin, Manager | Danh sach danh muc |
| /admin/category/add | GET | Admin, Manager | Form them moi |
| /admin/category/insert | POST | Admin, Manager | Luu danh muc moi |
| /admin/category/edit?id=N | GET | Admin, Manager | Form chinh sua |
| /admin/category/update | POST | Admin, Manager | Luu chỉnh sua |
| /admin/category/delete?id=N | GET | Admin, Manager | Xoa danh muc |
| /image?fname=... | GET | Tat ca | Hien thi hinh anh upload |

---

## 7. Kiem Thu JPA Doc Lap

Kiem tra ket noi JPA va tu dong tao bang trong SQL Server ma khong can Tomcat:

```bash
mvn compile exec:java -Dexec.mainClass=vn.iotstar.repository.Test
```

Hoac trong Eclipse: mo `Test.java` -> Chuot phai -> Run As -> Java Application.