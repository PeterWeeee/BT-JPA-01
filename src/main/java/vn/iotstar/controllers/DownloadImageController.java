package vn.iotstar.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.constant.Constant;

@WebServlet(urlPatterns = { "/image" })
public class DownloadImageController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        
        if (fileName != null && !fileName.trim().isEmpty()) {
            File file = new File(Constant.DIR + File.separator + "category" + File.separator + fileName);
            if (!file.exists() || !file.isFile()) {
                file = new File(Constant.DIR + File.separator + fileName);
            }

            if (file.exists() && file.isFile()) {
                if (fileName.toLowerCase().endsWith(".png")) {
                    resp.setContentType("image/png");
                } else if (fileName.toLowerCase().endsWith(".gif")) {
                    resp.setContentType("image/gif");
                } else {
                    resp.setContentType("image/jpeg");
                }

                try (FileInputStream in = new FileInputStream(file);
                     OutputStream out = resp.getOutputStream()) {
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    return;
                }
            }
        }

        // Nếu file không tồn tại hoặc chưa upload -> Trả về ảnh SVG placeholder
        resp.setContentType("image/svg+xml;charset=UTF-8");
        String placeholderSvg = "<svg xmlns='http://www.w3.org/2000/svg' width='120' height='90' viewBox='0 0 120 90'>"
                + "<rect width='120' height='90' fill='#f1f5f9' rx='4'/>"
                + "<text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='11' fill='#94a3b8'>No Image</text>"
                + "</svg>";
        resp.getWriter().write(placeholderSvg);
    }
}
