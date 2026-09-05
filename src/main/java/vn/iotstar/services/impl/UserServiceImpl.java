package vn.iotstar.services.impl;

import java.util.Date;
import java.util.List;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.utils.EmailUtil;

public class UserServiceImpl implements IUserService {

    private final IUserDao userDao = new UserDaoImpl();

    /** Thời gian hiệu lực OTP: 10 phút */
    private static final long OTP_EXPIRY_MS = 10 * 60 * 1000L;

    @Override
    public User login(String username, String password) {
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            return null;
        }
        User user = this.get(username.trim());
        if (user != null && password.equals(user.getPassWord())) {
            // Kiểm tra tài khoản đã kích hoạt chưa
            // Fallback users (status=1 theo mặc định) luôn đăng nhập được
            if (user.getStatus() != 0) {
                return user;
            }
            // Trả về user có status=0 để controller thông báo chưa kích hoạt
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
    public User findByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }
        return userDao.findByEmail(email.trim());
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
        // Tạo OTP
        String otp = EmailUtil.generateOtp();
        Date otpExpiry = new Date(System.currentTimeMillis() + OTP_EXPIRY_MS);

        // Tạo user với status=0 (chưa kích hoạt)
        User newUser = new User(email, username, fullname, password, "default-avatar.png", 3, phone, new Date());
        newUser.setStatus(0);
        newUser.setOtpCode(otp);
        newUser.setOtpExpiry(otpExpiry);

        userDao.insert(newUser);

        // Gửi email OTP kích hoạt
        EmailUtil.sendActivationOtp(email, otp);
        return true;
    }

    @Override
    public boolean activateAccount(String email, String otp) {
        if (email == null || otp == null) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) return false;

        // Kiểm tra OTP khớp và còn hiệu lực
        if (otp.trim().equals(user.getOtpCode())
                && user.getOtpExpiry() != null
                && new Date().before(user.getOtpExpiry())) {
            user.setStatus(1);
            user.setOtpCode(null);
            user.setOtpExpiry(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean sendOtpResetPassword(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) return false;

        String otp = EmailUtil.generateOtp();
        Date otpExpiry = new Date(System.currentTimeMillis() + OTP_EXPIRY_MS);
        user.setOtpCode(otp);
        user.setOtpExpiry(otpExpiry);
        userDao.update(user);

        return EmailUtil.sendResetPasswordOtp(email.trim(), otp);
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        if (email == null || otp == null || newPassword == null) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) return false;

        if (otp.trim().equals(user.getOtpCode())
                && user.getOtpExpiry() != null
                && new Date().before(user.getOtpExpiry())) {
            user.setPassWord(newPassword);
            user.setOtpCode(null);
            user.setOtpExpiry(null);
            userDao.update(user);
            return true;
        }
        return false;
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
