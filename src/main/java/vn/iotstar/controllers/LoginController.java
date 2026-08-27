package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.constant.Constant;
import vn.iotstar.models.UserModel;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/login" })
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 1. Kiểm tra nếu đã có Session đăng nhập -> Chuyển hướng sang /waiting
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // 2. Kiểm tra Cookie Remember Me (theo slide 01 & slide 06)
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (Constant.COOKIE_REMEMBER.equals(cookie.getName())) {
                    req.setAttribute("rememberedUser", cookie.getValue());
                    req.setAttribute("isRemembered", true);
                    break;
                }
            }
        }

        // Forward đến trang giao diện đăng nhập
        req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // Cấu hình UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        boolean isRememberMe = "on".equalsIgnoreCase(remember) || "true".equalsIgnoreCase(remember);

        // Kiểm tra validation rỗng
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ tài khoản và mật khẩu!");
            req.setAttribute("rememberedUser", username);
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
            return;
        }

        // Gọi tầng Service kiểm tra thông tin đăng nhập
        UserModel user = userService.login(username.trim(), password);

        if (user != null) {
            // A. ĐĂNG NHẬP VỚI SESSION: Lưu thông tin tài khoản vào Session
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, user);

            // B. ĐĂNG NHẬP VỚI COOKIE: Xử lý ghi nhớ tài khoản (Remember Me)
            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username.trim());
                cookie.setMaxAge(24 * 60 * 60); // Lưu 24 giờ
                cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                resp.addCookie(cookie);
            } else {
                // Nếu không tích chọn -> Xóa Cookie cũ nếu có
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, "");
                cookie.setMaxAge(0);
                cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                resp.addCookie(cookie);
            }

            // Chuyển hướng sang trang điều phối WaitingController
            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            // Đăng nhập thất bại -> Gửi thông báo lỗi về trang Login
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không chính xác!");
            req.setAttribute("rememberedUser", username);
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
        }
    }
}
