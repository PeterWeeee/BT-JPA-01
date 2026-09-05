package vn.iotstar.models;

import java.util.Date;
import vn.iotstar.entity.User;

/**
 * UserModel kế thừa từ User Entity để duy trì tính tương thích ngược với các controller hoặc session cũ.
 */
public class UserModel extends User {
    private static final long serialVersionUID = 1L;

    public UserModel() {
        super();
    }

    public UserModel(int id, String email, String userName, String fullName, String passWord, String avatar,
            int roleid, String phone, Date createdDate) {
        super(id, email, userName, fullName, passWord, avatar, roleid, phone, createdDate);
    }

    public UserModel(String email, String userName, String fullName, String passWord, String avatar, int roleid,
            String phone, Date createdDate) {
        super(email, userName, fullName, passWord, avatar, roleid, phone, createdDate);
    }
}
