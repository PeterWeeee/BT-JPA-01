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

/**
 * ForgotPasswordController – Bước 1: Nhập email để nhận OTP đặt lại mật khẩu.
 * URL: /forgot-password
 */
@WebServlet(urlPatterns = { "/forgot-password" })
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập địa chỉ email!");
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
            return;
        }

        boolean sent = userService.sendOtpResetPassword(email.trim());

        if (sent) {
            // Chuyển sang trang nhập OTP + mật khẩu mới
            resp.sendRedirect(req.getContextPath() + "/reset-password?email=" +
                java.net.URLEncoder.encode(email.trim(), "UTF-8"));
        } else {
            req.setAttribute("alert", "Email không tồn tại trong hệ thống!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher(Constant.Path.FORGOT_PASSWORD).forward(req, resp);
        }
    }
}
