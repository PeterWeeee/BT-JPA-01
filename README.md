# BT-JPA-01: Quan Ly Danh Muc & Xac Thuc Nguoi Dung

Ung dung Web Java phat trien theo kien truc MVC 3 tang, su dung Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0), Hibernate ORM 7.x (JPA 3.0) va he quan tri co so du lieu Microsoft SQL Server.

---

## 1. Chuc Nang Chinh

### Quan ly Danh muc (Category CRUD)
- **Xem danh sach danh muc**: Hien thi bang danh sach danh muc, hinh anh, ten va trang thai (Hoat dong / Khoa).
- **Tim kiem danh muc**: Tim kiem danh muc theo tu khoa ten danh muc.
- **Them moi danh muc**: Nhap ten danh muc, nhap lien ket anh hoac tai tep anh truc tiep tu may tinh. Co kiem tra tinh hop le va thong bao trung lap.
- **Chinh sua danh muc**: Cap nhat thong tin danh muc, ho tro tai anh moi thay the (tu dong xoa anh cu tren o dia).
- **Xoa danh muc**: Xoa ban ghi trong database bang JPA EntityManager.remove(), ho tro cascade xoa cac thuc the con lien quan.

### Xac thuc va Phan quyen (Authentication & Authorization)
- **Dang ky tai khoan (/register)**: Tao tai khoan moi, kiem tra trung lap ten dang nhap va email.
- **Dang nhap (/login)**: Xac thuc tai khoan, ho tro tinh nang ghi nho ten dang nhap (Remember Me) qua Cookie.
  - Cookie chi luu **ten dang nhap** (khong luu mat khau) trong 24 gio de dien san o username khi mo lai trang login.
- **Session**: Sau khi dang nhap thanh cong, UserModel duoc luu vao HttpSession (phien lam viec phia server, song 30 phut). Moi request tiep theo server doc session de biet nguoi dung la ai va co quyen gi.
- **Phan quyen theo vai tro** kiem tra tap trung qua AuthFilter (@WebFilter("/admin/*")):
  - Admin (Role 1) -> Trang quan tri (/admin/home) + toan bo /admin/*
  - Manager (Role 2) -> Trang quan ly (/manager/home) + toan bo /admin/* (quan ly danh muc)
  - User (Role 3) -> Trang chu (/home) - khong duoc vao /admin/*
- **Dang xuat (/logout)**: Huy phien lam viec (session.invalidate()) va chuyen huong ve trang dang nhap.

---

## 2. Cong Nghe Su Dung

- **Ngon ngu**: Java 21 (LTS)
- **Chuan Web**: Jakarta EE 10 (Servlet API 6.1, JSP API 4.0, JSTL 3.0)
- **ORM / JPA**: Hibernate ORM 7.4.6.Final (Jakarta Persistence API 3.0+)
- **Co so du lieu**: Microsoft SQL Server (Driver: mssql-jdbc:12.8.1.jre11)
- **Build Tool**: Apache Maven
- **Giao dien**: JSP, JSTL Core Tags, Bootstrap 5.3

---

## 3. Cau Truc Thu Muc

```
BT-JPA-01
pom.xml
README.md
src/main/java/vn/iotstar/
  connection/
    DBConnection.java          - Ket noi JDBC (dung cho User)
  constant/
    Constant.java              - Hang so he thong & thu muc C:\upload
  controllers/
    AdminHomeController.java
    CategoryController.java    - Dieu khien CRUD Category
    DownloadImageController.java
    HomeController.java
    LoginController.java
    LogoutController.java
    ManagerHomeController.java
    RegisterController.java
    WaitingController.java
  dao/
    ICategoryDao.java
    IUserDao.java
    impl/
      CategoryDaoImpl.java     - DAO JPA xu ly Category
      UserDaoImpl.java         - DAO JDBC xu ly User
  entity/
    Category.java              - Entity Category (@OneToMany Video)
    Video.java                 - Entity Video (@ManyToOne Category)
  filters/
    AuthFilter.java            - Phan quyen tap trung cho /admin/*
  models/
    CategoryModel.java
    UserModel.java
  repository/
    JpaConfig.java             - Singleton EntityManagerFactory
    Test.java                  - Test runner JPA
  services/
    ICategoryService.java
    IUserService.java
    impl/
      CategoryServiceImpl.java
      UserServiceImpl.java
src/main/resources/
  META-INF/
    persistence.xml            - Cau hinh JPA (persistence-unit: jpa-hibernate-sqlserver)
src/main/webapp/
  WEB-INF/web.xml
  views/
    admin/
      category-add.jsp
      category-edit.jsp
      category-list.jsp
    common/
      header.jsp
      topbar.jsp
    admin-home.jsp
    home.jsp
    login.jsp
    manager-home.jsp
    register.jsp
    error.jsp
```

---

## 4. Cau Hinh Co So Du Lieu

Project dung **hai** nguon du lieu song song:

| Phan | Co che | Database | Port |
|------|--------|----------|------|
| Category & Video | JPA / Hibernate (persistence.xml) | webst4 | 1434 |
| User | JDBC thuan (DBConnection.java) | LTWeb | 1433 |

Chinh sua thong so ket noi JPA trong src/main/resources/META-INF/persistence.xml:

```xml
<persistence-unit name="jpa-hibernate-sqlserver">
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

Chinh sua thong so ket noi JDBC cho User trong DBConnection.java (field dbName, portNumber).

Thu muc luu tru hinh anh tai len mac dinh tai C:\upload\category. Ung dung se tu dong tao thu muc nay neu chua co.

---

## 5. Huong Dan Khoi Chay

1. Import du an: Mo Eclipse / STS -> File -> Import -> Existing Maven Projects -> Chon thu muc BT-JPA-01.
2. Khoi chay may chu: Chuot phai vao du an -> Run As -> Run on Server (Apache Tomcat 10.1 hoac Tomcat 11).
3. Truy cap ung dung: Mo trinh duyet tai http://localhost:8080/BT-JPA-01/

---

## 6. Danh Sach URL Chinh

| URL Pattern | Phuong thuc | Quyen | Chuc nang |
| :--- | :---: | :---: | :--- |
| /login | GET / POST | Tat ca | Dang nhap he thong |
| /register | GET / POST | Tat ca | Dang ky tai khoan |
| /logout | GET | Tat ca | Dang xuat |
| /home | GET | Tat ca | Trang chu |
| /admin/home | GET | Admin | Quan ly nguoi dung |
| /manager/home | GET | Manager | Trang danh cho Manager |
| /admin/categories | GET | Admin, Manager | Danh sach danh muc |
| /admin/category/add | GET | Admin, Manager | Form them moi danh muc |
| /admin/category/insert | POST | Admin, Manager | Luu danh muc moi & upload anh |
| /admin/category/edit?id=... | GET | Admin, Manager | Form chinh sua danh muc |
| /admin/category/update | POST | Admin, Manager | Cap nhat thong tin danh muc |
| /admin/category/delete?id=... | GET | Admin, Manager | Xoa danh muc theo ID |
| /image?fname=... | GET | Tat ca | Hien thi hinh anh tu thu muc upload |

---

## 7. Kiem Thu JPA Doc Lap

Chay thu nghiem ket noi JPA va tu dong sinh bang vao SQL Server ma khong can khoi dong Tomcat:
- Trong Eclipse: Mo file src/main/java/vn/iotstar/repository/Test.java -> Chuot phai chon Run As -> Java Application.
- Hoac chay qua dong lenh:
  ```bash
  mvn compile exec:java -Dexec.mainClass=vn.iotstar.repository.Test
  ```

---

## 8. Cac Loi Da Sua (Bug Fixes)

| # | Loi | File | Muc do |
|---|-----|------|--------|
| 1 | EntityManagerFactory tao moi moi request -> ro ri tai nguyen | JpaConfig.java | Nghiem trong |
| 2 | Ten persistence-unit sai (mysql thay vi sqlserver) | JpaConfig.java, persistence.xml | Nham lan |
| 3+4 | merge() detached entity co cascade -> xoa nham toan bo Video khi update Category | CategoryDaoImpl.java | Nghiem trong |
| 5 | Phan trang khong co tai lieu ro ve page 0-based | CategoryDaoImpl.java | Can than |
| 6 | Hai class CategoryDao rong trung lap | dao/CategoryDao.java, dao/impl/CategoryDao.java | Code smell |
| 7 | delete() service nuot exception -> controller khong biet loi | CategoryServiceImpl.java | Logic |
| 8 | Hai DB/co che song song khong dong nhat | DBConnection.java | Kien truc |
| 9 | @PersistenceContext dat sai tren class | JpaConfig.java | Nho |
| 10 | CategoryController khong kiem tra session/role -> ai cung vao duoc /admin/* | AuthFilter.java (moi) | Bao mat |