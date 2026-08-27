package vn.iotstar.services.impl;

import java.sql.Date;
import java.util.List;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.models.UserModel;
import vn.iotstar.services.IUserService;

public class UserServiceImpl implements IUserService {

    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public UserModel login(String username, String password) {
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            return null;
        }
        UserModel user = this.get(username.trim());
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public UserModel get(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return userDao.get(username.trim());
    }

    @Override
    public UserModel get(int id) {
        return userDao.get(id);
    }

    @Override
    public void insert(UserModel user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (checkExistUsername(username)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        UserModel newUser = new UserModel(email, username, fullname, password, "default-avatar.png", 3, phone, date);
        userDao.insert(newUser);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public List<UserModel> getAll() {
        return userDao.getAll();
    }
}
