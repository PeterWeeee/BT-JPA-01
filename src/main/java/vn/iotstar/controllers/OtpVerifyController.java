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
 * OtpVerifyController – Xử lý kích hoạt tài khoản bằng OTP.
 * URL: /verify-otp?email=xxx&type=activate
 */
@WebServlet(urlPatterns = { "/verify-otp" })
public class OtpVerifyController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String type  = req.getParameter("type");

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        req.setAttribute("email", email.trim());
        req.setAttribute("type", type != null ? type : "activate");
        req.getRequestDispatcher(Constant.Path.VERIFY_OTP).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp   = req.getParameter("otp");
        String type  = req.getParameter("type");

        if (email == null || otp == null || email.trim().isEmpty() || otp.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập mã OTP!");
            req.setAttribute("email", email);
            req.setAttribute("type", type);
            req.getRequestDispatcher(Constant.Path.VERIFY_OTP).forward(req, resp);
            return;
        }

        boolean success = userService.activateAccount(email.trim(), otp.trim());

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login?activated=success");
        } else {
            req.setAttribute("alert", "Mã OTP không hợp lệ hoặc đã hết hạn! Vui lòng thử lại.");
            req.setAttribute("email", email.trim());
            req.setAttribute("type", type);
            req.getRequestDispatcher(Constant.Path.VERIFY_OTP).forward(req, resp);
        }
    }
}
