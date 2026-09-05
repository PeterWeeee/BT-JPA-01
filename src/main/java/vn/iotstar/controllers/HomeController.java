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

@WebServlet(urlPatterns = { "/home", "/user/home" })
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User account = (session != null) ? (User) session.getAttribute(Constant.SESSION_ACCOUNT) : null;
        req.setAttribute("account", account);
        req.getRequestDispatcher(Constant.Path.HOME).forward(req, resp);
    }
}
