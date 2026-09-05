package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.constant.Constant;
import vn.iotstar.models.UserModel;

@WebServlet(urlPatterns = { "/waiting" })
public class WaitingController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            UserModel user = (UserModel) session.getAttribute(Constant.SESSION_ACCOUNT);
            
            // Phân quyền theo RoleID 
            if (user.getRoleid() == 1) {
                // 1: Quyền Admin -> Đến trang Quản trị
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else if (user.getRoleid() == 2) {
                // 2: Quyền Manager -> Đến trang Quản lý
                resp.sendRedirect(req.getContextPath() + "/manager/home");
            } else {
                // 3 hoặc khác: Quyền User -> Đến trang Chủ người dùng
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            // Chưa đăng nhập -> Quay về trang Login
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
