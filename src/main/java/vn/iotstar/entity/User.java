package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "email", columnDefinition = "nvarchar(255)")
    private String email;

    @Column(name = "username", columnDefinition = "nvarchar(50)", nullable = false, unique = true)
    private String userName;

    @Column(name = "fullname", columnDefinition = "nvarchar(100)")
    private String fullName;

    @Column(name = "password", columnDefinition = "nvarchar(255)", nullable = false)
    private String passWord;

    @Column(name = "avatar", columnDefinition = "nvarchar(500)")
    private String avatar;

    @Column(name = "roleid")
    private int roleid; // 1: Admin, 2: Manager, 3: User

    @Column(name = "phone", columnDefinition = "nvarchar(20)")
    private String phone;

    @Temporal(TemporalType.DATE)
    @Column(name = "createddate")
    private Date createdDate;

    public User() {
        super();
    }

    public User(int id, String email, String userName, String fullName, String passWord, String avatar, int roleid,
            String phone, Date createdDate) {
        super();
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.passWord = passWord;
        this.avatar = avatar;
        this.roleid = roleid;
        this.phone = phone;
        this.createdDate = createdDate;
    }

    public User(String email, String userName, String fullName, String passWord, String avatar, int roleid,
            String phone, Date createdDate) {
        super();
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.passWord = passWord;
        this.avatar = avatar;
        this.roleid = roleid;
        this.phone = phone;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Alias cho chuẩn JavaBeans
    public String getUsername() {
        return userName;
    }

    public void setUsername(String username) {
        this.userName = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Alias cho chuẩn JavaBeans
    public String getFullname() {
        return fullName;
    }

    public void setFullname(String fullname) {
        this.fullName = fullname;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    // Alias cho chuẩn JavaBeans
    public String getPassword() {
        return passWord;
    }

    public void setPassword(String password) {
        this.passWord = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", email=" + email + ", userName=" + userName + ", fullName=" + fullName
                + ", roleid=" + roleid + ", phone=" + phone + ", createdDate=" + createdDate + "]";
    }
}
