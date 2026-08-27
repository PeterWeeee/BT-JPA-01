package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.constant.Constant;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // Cấu hình UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Kiểm tra dữ liệu rỗng
        if (username == null || password == null || email == null || 
            username.trim().isEmpty() || password.trim().isEmpty() || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng điền đầy đủ các thông tin bắt buộc!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        // Kiểm tra trùng Email
        if (userService.checkExistEmail(email.trim())) {
            req.setAttribute("alert", "Email này đã được sử dụng!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        // Kiểm tra trùng Username
        if (userService.checkExistUsername(username.trim())) {
            req.setAttribute("alert", "Tên đăng nhập này đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        // Thực hiện đăng ký
        boolean isSuccess = userService.register(username.trim(), password, email.trim(), fullname, phone);

        if (isSuccess) {
            resp.sendRedirect(req.getContextPath() + "/login?registered=success");
        } else {
            req.setAttribute("alert", "Lỗi hệ thống trong quá trình đăng ký!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
        }
    }
}
