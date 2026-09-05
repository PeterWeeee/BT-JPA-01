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
 * ResetPasswordController – Bước 2: Nhập OTP + mật khẩu mới để đặt lại mật khẩu.
 * URL: /reset-password?email=xxx
 */
@WebServlet(urlPatterns = { "/reset-password" })
public class ResetPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }
        req.setAttribute("email", email.trim());
        req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email       = req.getParameter("email");
        String otp         = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPwd  = req.getParameter("confirmPassword");

        // Validate
        if (email == null || otp == null || newPassword == null ||
                email.trim().isEmpty() || otp.trim().isEmpty() || newPassword.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng điền đầy đủ thông tin!");
            req.setAttribute("email", email);
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPwd)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        if (newPassword.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
            return;
        }

        boolean success = userService.resetPassword(email.trim(), otp.trim(), newPassword);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login?reset=success");
        } else {
            req.setAttribute("alert", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            req.setAttribute("email", email.trim());
            req.getRequestDispatcher(Constant.Path.RESET_PASSWORD).forward(req, resp);
        }
    }
}
