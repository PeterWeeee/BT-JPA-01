package vn.iotstar.services.impl;

import java.util.Date;
import java.util.List;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;

public class UserServiceImpl implements IUserService {

    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            return null;
        }
        User user = this.get(username.trim());
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return userDao.get(username.trim());
    }

    @Override
    public User get(int id) {
        return userDao.get(id);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void delete(int id) throws Exception {
        userDao.delete(id);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (checkExistUsername(username)) {
            return false;
        }
        User newUser = new User(email, username, fullname, password, "default-avatar.png", 3, phone, new Date());
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
    public List<User> getAll() {
        return userDao.getAll();
    }
}
