package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.models.UserModel;

public class UserDaoImpl extends DBConnection implements IUserDao {

    // Danh sách dự phòng (In-Memory Fallback) khi chưa khởi động SQL Server
    private static final List<UserModel> fallbackUsers = new ArrayList<>();
    static {
        long now = System.currentTimeMillis();
        fallbackUsers.add(new UserModel(1, "admin@iotstar.vn", "admin", "Quản Trị Viên", "123", "admin.png", 1, "0901234567", new Date(now)));
        fallbackUsers.add(new UserModel(2, "manager@iotstar.vn", "manager", "Quản Lý Cửa Hàng", "123", "manager.png", 2, "0902345678", new Date(now)));
        fallbackUsers.add(new UserModel(3, "user@iotstar.vn", "user", "Nguyễn Văn A", "123", "user.png", 3, "0903456789", new Date(now)));
        fallbackUsers.add(new UserModel(4, "trungnh@hcmute.edu.vn", "trungnh", "ThS. Nguyễn Hữu Trung", "123", "trungnh.png", 1, "0908617108", new Date(now)));
    }

    @Override
    public UserModel get(String username) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel user = new UserModel();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setUserName(rs.getString("username"));
                    user.setFullName(rs.getString("fullname"));
                    user.setPassWord(rs.getString("password"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setRoleid(rs.getInt("roleid"));
                    user.setPhone(rs.getString("phone"));
                    user.setCreatedDate(rs.getDate("createddate"));
                    return user;
                }
            }
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi truy vấn Database (sử dụng dữ liệu mẫu dự phòng): " + e.getMessage());
            for (UserModel u : fallbackUsers) {
                if (u.getUserName().equalsIgnoreCase(username)) {
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public UserModel get(int id) {
        String sql = "SELECT * FROM [User] WHERE id = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel user = new UserModel();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setUserName(rs.getString("username"));
                    user.setFullName(rs.getString("fullname"));
                    user.setPassWord(rs.getString("password"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setRoleid(rs.getInt("roleid"));
                    user.setPhone(rs.getString("phone"));
                    user.setCreatedDate(rs.getDate("createddate"));
                    return user;
                }
            }
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi get(id): " + e.getMessage());
            for (UserModel u : fallbackUsers) {
                if (u.getId() == id) {
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public void insert(UserModel user) {
        String sql = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createddate) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate() != null ? user.getCreatedDate() : new Date(System.currentTimeMillis()));
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi insert vào Database: " + e.getMessage());
            user.setId(fallbackUsers.size() + 1);
            fallbackUsers.add(user);
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        String sql = "SELECT 1 FROM [User] WHERE email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            for (UserModel u : fallbackUsers) {
                if (email != null && email.equalsIgnoreCase(u.getEmail())) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        String sql = "SELECT 1 FROM [User] WHERE username = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            for (UserModel u : fallbackUsers) {
                if (username != null && username.equalsIgnoreCase(u.getUserName())) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        String sql = "SELECT 1 FROM [User] WHERE phone = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            for (UserModel u : fallbackUsers) {
                if (phone != null && phone.equalsIgnoreCase(u.getPhone())) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public List<UserModel> getAll() {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setPassWord(rs.getString("password"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                user.setCreatedDate(rs.getDate("createddate"));
                list.add(user);
            }
            return list;
        } catch (Exception e) {
            return new ArrayList<>(fallbackUsers);
        }
    }
}
