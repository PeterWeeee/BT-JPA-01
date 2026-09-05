package vn.iotstar.services;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String password);
    User get(String username);
    User get(int id);
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    List<User> getAll();
}
