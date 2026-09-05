package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserDao {
    User get(String username);
    User get(int id);
    User findByEmail(String email);
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    List<User> getAll();
}
