package vn.iotstar.constant;

import java.io.File;

public class Constant {
    public static final String SESSION_ACCOUNT = "account";
    public static final String COOKIE_REMEMBER = "username";
    
    // Thư mục lưu trữ hình ảnh upload (tự động tạo nếu chưa có)
    public static final String DIR = "C:" + File.separator + "upload";
    
    // Đường dẫn views
    public static class Path {
        public static final String LOGIN = "/views/login.jsp";
        public static final String REGISTER = "/views/register.jsp";
        public static final String HOME = "/views/home.jsp";
        public static final String ADMIN_HOME = "/views/admin-home.jsp";
        public static final String MANAGER_HOME = "/views/manager-home.jsp";
        public static final String COOKIE_DEMO = "/views/cookie-demo.jsp";
        public static final String ERROR = "/views/error.jsp";
        
        // Category views
        public static final String CATEGORY_LIST = "/views/admin/category-list.jsp";
        public static final String CATEGORY_ADD = "/views/admin/category-add.jsp";
        public static final String CATEGORY_EDIT = "/views/admin/category-edit.jsp";
    }
}
