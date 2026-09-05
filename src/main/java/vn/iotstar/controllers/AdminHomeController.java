package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.constant.Constant;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/admin/home" })
public class AdminHomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        // Bảo vệ route: Chỉ cho phép người dùng có roleid == 1 truy cập
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (currentUser.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Lấy danh sách toàn bộ người dùng để hiển thị trên Dashboard Admin
        List<User> userList = userService.getAll();
        req.setAttribute("userList", userList);
        req.setAttribute("currentUser", currentUser);

        req.getRequestDispatcher(Constant.Path.ADMIN_HOME).forward(req, resp);
    }
}
