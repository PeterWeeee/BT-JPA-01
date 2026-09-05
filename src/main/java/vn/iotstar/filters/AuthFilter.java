package vn.iotstar.filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.constant.Constant;
import vn.iotstar.entity.User;

/**
 * AuthFilter - Bo loc phan quyen tap trung cho toan bo khu vuc Admin.
 * Bao ve tat ca URL /admin/*:
 *  - Chua dang nhap          -> redirect /login
 *  - role = 3 (User)         -> redirect /home (khong du quyen)
 *  - role = 2 (Manager)      -> DUOC PHEP (quan ly danh muc)
 *  - role = 1 (Admin)        -> DUOC PHEP (toan quyen)
 */
@WebFilter("/admin/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpResp = (HttpServletResponse) response;

        HttpSession session = httpReq.getSession(false);

        // 1. Kiem tra da dang nhap chua
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            httpResp.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        // 2. Kiem tra quyen: Admin (role=1) va Manager (role=2) duoc phep vao /admin/*
        //    User thuong (role=3) bi tu choi.
        User currentUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        int role = currentUser.getRoleid();
        if (role != 1 && role != 2) {
            httpResp.sendRedirect(httpReq.getContextPath() + "/home");
            return;
        }

        // 3. Du dieu kien -> cho request di tiep den Controller
        chain.doFilter(request, response);
    }
}
