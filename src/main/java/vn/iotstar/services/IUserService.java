package vn.iotstar.services;

import java.util.List;
import vn.iotstar.models.UserModel;

public interface IUserService {
    UserModel login(String username, String password);
    UserModel get(String username);
    UserModel get(int id);
    void insert(UserModel user);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    List<UserModel> getAll();
}
