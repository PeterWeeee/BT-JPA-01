package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.models.UserModel;

public interface IUserDao {
    UserModel get(String username);
    UserModel get(int id);
    void insert(UserModel user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    List<UserModel> getAll();
}
