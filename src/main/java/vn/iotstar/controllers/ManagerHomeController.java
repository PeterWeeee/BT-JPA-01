package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.constant.Constant;
import vn.iotstar.entity.User;

@WebServlet(urlPatterns = { "/manager/home" })
public class ManagerHomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        // Bảo vệ route: Chỉ cho phép người dùng có roleid == 2 (hoặc 1) truy cập
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (currentUser.getRoleid() != 2 && currentUser.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        req.setAttribute("currentUser", currentUser);
        req.getRequestDispatcher(Constant.Path.MANAGER_HOME).forward(req, resp);
    }
}
