package vn.iotstar.services;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String password);
    User get(String username);
    User get(int id);
    User findByEmail(String email);
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    List<User> getAll();

    /**
     * Kích hoạt tài khoản bằng OTP.
     * @param email  email người dùng
     * @param otp    mã OTP người dùng nhập
     * @return true nếu OTP đúng và còn hiệu lực
     */
    boolean activateAccount(String email, String otp);

    /**
     * Tạo OTP và gửi email để đặt lại mật khẩu.
     * @param email  email cần reset
     * @return true nếu email tồn tại và gửi thành công
     */
    boolean sendOtpResetPassword(String email);

    /**
     * Xác thực OTP và đặt mật khẩu mới.
     * @param email        email người dùng
     * @param otp          mã OTP người dùng nhập
     * @param newPassword  mật khẩu mới
     * @return true nếu thành công
     */
    boolean resetPassword(String email, String otp, String newPassword);
}
