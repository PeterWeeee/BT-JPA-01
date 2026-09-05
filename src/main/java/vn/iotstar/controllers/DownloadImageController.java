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

/**
 * DownloadImageController – Phục vụ ảnh từ thư mục C:/upload/.
 *
 * Hỗ trợ 2 kiểu gọi:
 *  - /download-image?filename=product/abc.jpg  (subfolder + filename)
 *  - /download-image?fname=abc.jpg             (tương thích cũ, tìm trong category/)
 */
@WebServlet(urlPatterns = { "/image", "/download-image" })
public class DownloadImageController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String filePath = null;

        // Kiểu mới: filename=product/abc.jpg
        String filename = req.getParameter("filename");
        if (filename != null && !filename.trim().isEmpty()) {
            // Ngăn path traversal
            filename = filename.replace("..", "").replace("\\", "/");
            filePath = Constant.DIR + File.separator + filename.replace("/", File.separator);
        }

        // Kiểu cũ: fname=abc.jpg
        if (filePath == null) {
            String fname = req.getParameter("fname");
            if (fname != null && !fname.trim().isEmpty()) {
                // Tìm trong category/ trước, rồi gốc
                File f = new File(Constant.DIR + File.separator + "category" + File.separator + fname);
                if (f.exists() && f.isFile()) {
                    filePath = f.getAbsolutePath();
                } else {
                    filePath = Constant.DIR + File.separator + fname;
                }
            }
        }

        if (filePath != null) {
            File file = new File(filePath);
            if (file.exists() && file.isFile()) {
                String name = file.getName().toLowerCase();
                if (name.endsWith(".png")) {
                    resp.setContentType("image/png");
                } else if (name.endsWith(".gif")) {
                    resp.setContentType("image/gif");
                } else if (name.endsWith(".webp")) {
                    resp.setContentType("image/webp");
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

        // Placeholder SVG khi file không tồn tại
        resp.setContentType("image/svg+xml;charset=UTF-8");
        String placeholderSvg = "<svg xmlns='http://www.w3.org/2000/svg' width='120' height='120' viewBox='0 0 120 120'>"
                + "<rect width='120' height='120' fill='#f1f5f9' rx='4'/>"
                + "<text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' "
                + "font-family='sans-serif' font-size='11' fill='#94a3b8'>No Image</text>"
                + "</svg>";
        resp.getWriter().write(placeholderSvg);
    }
}
