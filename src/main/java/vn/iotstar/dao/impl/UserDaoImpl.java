package vn.iotstar.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements IUserDao {

    // Danh sách dự phòng (In-Memory Fallback) khi chưa khởi động SQL Server
    private static final List<User> fallbackUsers = new ArrayList<>();
    static {
        Date now = new Date();
        fallbackUsers.add(new User(1, "admin@iotstar.vn", "admin", "Quản Trị Viên", "123", "admin.png", 1, "0901234567", now));
        fallbackUsers.add(new User(2, "manager@iotstar.vn", "manager", "Quản Lý Cửa Hàng", "123", "manager.png", 2, "0902345678", now));
        fallbackUsers.add(new User(3, "user@iotstar.vn", "user", "Nguyễn Văn A", "123", "user.png", 3, "0903456789", now));
        fallbackUsers.add(new User(4, "trungnh@hcmute.edu.vn", "trungnh", "ThS. Nguyễn Hữu Trung", "123", "trungnh.png", 1, "0908617108", now));
    }

    @Override
    public User get(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.userName = :username";
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("username", username.trim());
            List<User> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list.get(0);
            }
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Không thể truy vấn JPA (sử dụng tài khoản mẫu dự phòng): " + e.getMessage());
        } finally {
            enma.close();
        }

        // Fallback in-memory khi CSDL trống hoặc chưa kết nối
        for (User u : fallbackUsers) {
            if (u.getUserName().equalsIgnoreCase(username.trim())) {
                return u;
            }
        }
        return null;
    }

    @Override
    public User get(int id) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            User user = enma.find(User.class, id);
            if (user != null) {
                return user;
            }
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi get(id) qua JPA: " + e.getMessage());
        } finally {
            enma.close();
        }

        for (User u : fallbackUsers) {
            if (u.getId() == id) {
                return u;
            }
        }
        return null;
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            if (user.getCreatedDate() == null) {
                user.setCreatedDate(new Date());
            }
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi insert qua JPA (lưu vào bộ nhớ dự phòng): " + e.getMessage());
            if (trans.isActive()) {
                trans.rollback();
            }
            user.setId(fallbackUsers.size() + 1);
            fallbackUsers.add(user);
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);
            trans.commit();
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi update qua JPA: " + e.getMessage());
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = enma.find(User.class, id);
            if (user != null) {
                enma.remove(user);
            } else {
                throw new Exception("Không tìm thấy người dùng có id = " + id);
            }
            trans.commit();
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi delete qua JPA: " + e.getMessage());
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("email", email.trim());
            Long count = query.getSingleResult();
            if (count != null && count > 0) {
                return true;
            }
        } catch (Exception e) {
            for (User u : fallbackUsers) {
                if (email.trim().equalsIgnoreCase(u.getEmail())) {
                    return true;
                }
            }
        } finally {
            enma.close();
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.userName = :username";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("username", username.trim());
            Long count = query.getSingleResult();
            if (count != null && count > 0) {
                return true;
            }
        } catch (Exception e) {
            for (User u : fallbackUsers) {
                if (username.trim().equalsIgnoreCase(u.getUserName())) {
                    return true;
                }
            }
        } finally {
            enma.close();
        }
        return false;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.phone = :phone";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("phone", phone.trim());
            Long count = query.getSingleResult();
            if (count != null && count > 0) {
                return true;
            }
        } catch (Exception e) {
            for (User u : fallbackUsers) {
                if (phone.trim().equalsIgnoreCase(u.getPhone())) {
                    return true;
                }
            }
        } finally {
            enma.close();
        }
        return false;
    }

    @Override
    public List<User> getAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createNamedQuery("User.findAll", User.class);
            List<User> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            System.err.println("[UserDaoImpl] Lỗi getAll() qua JPA: " + e.getMessage());
        } finally {
            enma.close();
        }
        return new ArrayList<>(fallbackUsers);
    }
}
