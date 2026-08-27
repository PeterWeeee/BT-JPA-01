package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.constant.Constant;

@WebServlet(urlPatterns = { "/cookie-demo" })
public class CookieDemoController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        String value = req.getParameter("value");

        if ("add".equalsIgnoreCase(action) && name != null && value != null && !name.trim().isEmpty()) {
            // 1. Tạo Cookie mới (Slide 01)
            Cookie cookie = new Cookie(name.trim(), value.trim());
            cookie.setMaxAge(60 * 60 * 24); // 24 giờ
            cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
            resp.addCookie(cookie);
            resp.sendRedirect(req.getContextPath() + "/cookie-demo?msg=added");
            return;
        } else if ("delete".equalsIgnoreCase(action) && name != null && !name.trim().isEmpty()) {
            // 2. Xóa Cookie (Slide 01: Set age = 0)
            Cookie cookie = new Cookie(name.trim(), "");
            cookie.setMaxAge(0);
            cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
            resp.addCookie(cookie);
            resp.sendRedirect(req.getContextPath() + "/cookie-demo?msg=deleted");
            return;
        }

        // 3. Đọc danh sách Cookie (Slide 01)
        Cookie[] cookies = req.getCookies();
        req.setAttribute("cookiesList", cookies);
        req.getRequestDispatcher(Constant.Path.COOKIE_DEMO).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
