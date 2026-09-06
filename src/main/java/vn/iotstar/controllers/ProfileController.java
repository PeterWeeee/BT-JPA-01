package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.constant.Constant;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 5,       // 5MB
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        req.setAttribute("profileUser", user);
        req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Validate
        if (fullname == null || fullname.trim().isEmpty()) {
            req.setAttribute("error", "Họ và tên không được để trống!");
            req.setAttribute("profileUser", sessionUser);
            req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
            return;
        }

        // Kiem tra thu muc avatar
        String uploadPath = Constant.DIR + File.separator + "avatar";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String avatarFilename = sessionUser.getAvatar(); // Giu nguyen avatar cu neu khong cap nhat

        try {
            Part part = req.getPart("avatarFile");
            if (part != null && part.getSize() > 0) {
                String originalFilename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int dotIndex = originalFilename.lastIndexOf(".");
                if (dotIndex > 0) {
                    ext = originalFilename.substring(dotIndex);
                }
                avatarFilename = sessionUser.getId() + "_" + UUID.randomUUID().toString() + ext;
                part.write(uploadPath + File.separator + avatarFilename);
            }

            // Cap nhat DB
            sessionUser.setFullName(fullname.trim());
            sessionUser.setPhone(phone != null ? phone.trim() : "");
            sessionUser.setAvatar(avatarFilename);

            userService.update(sessionUser);

            // Cap nhat lai session
            session.setAttribute(Constant.SESSION_ACCOUNT, sessionUser);
            
            resp.sendRedirect(req.getContextPath() + "/profile?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật hồ sơ: " + e.getMessage());
            req.setAttribute("profileUser", sessionUser);
            req.getRequestDispatcher(Constant.Path.PROFILE).forward(req, resp);
        }
    }
}