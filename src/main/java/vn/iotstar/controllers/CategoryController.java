package vn.iotstar.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.constant.Constant;
import vn.iotstar.entity.Category;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.impl.CategoryServiceImpl;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/list", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String url = req.getRequestURI();
        if (url.contains("/admin/categories") || url.contains("/admin/category/list")) {
            String keyword = req.getParameter("keyword");
            List<Category> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = cateService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = cateService.findAll();
            }
            req.setAttribute("listcate", list);
            req.getRequestDispatcher(Constant.Path.CATEGORY_LIST).forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher(Constant.Path.CATEGORY_ADD).forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                Category category = cateService.findById(id);
                req.setAttribute("cate", category);
            }
            req.getRequestDispatcher(Constant.Path.CATEGORY_EDIT).forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                try {
                    Category category = cateService.findById(id);
                    if (category != null) {
                        String oldImage = category.getImages();
                        cateService.delete(id);
                        if (oldImage != null && !oldImage.startsWith("http") && !oldImage.equals("avatar.png")) {
                            deleteFile(Constant.DIR + File.separator + "category" + File.separator + oldImage);
                            deleteFile(Constant.DIR + File.separator + oldImage);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            int status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;
            String images = req.getParameter("images");

            if (categoryname == null || categoryname.trim().isEmpty()) {
                req.setAttribute("alert", "Tên danh mục không được để trống!");
                req.getRequestDispatcher(Constant.Path.CATEGORY_ADD).forward(req, resp);
                return;
            }

            if (cateService.findByCategoryname(categoryname.trim()) != null) {
                req.setAttribute("alert", "Tên danh mục này đã tồn tại!");
                req.setAttribute("categoryname", categoryname);
                req.setAttribute("images", images);
                req.setAttribute("status", status);
                req.getRequestDispatcher(Constant.Path.CATEGORY_ADD).forward(req, resp);
                return;
            }

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR + File.separator + "category";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = (index > 0) ? filename.substring(index + 1) : "png";
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages("avatar.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }

        if (url.contains("/admin/category/update")) {
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            int status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;
            String images = req.getParameter("images");

            Category category = cateService.findById(categoryid);
            if (category != null) {
                if (categoryname == null || categoryname.trim().isEmpty()) {
                    req.setAttribute("alert", "Tên danh mục không được để trống!");
                    req.setAttribute("cate", category);
                    req.getRequestDispatcher(Constant.Path.CATEGORY_EDIT).forward(req, resp);
                    return;
                }

                Category exist = cateService.findByCategoryname(categoryname.trim());
                if (exist != null && exist.getCategoryId() != categoryid) {
                    req.setAttribute("alert", "Tên danh mục này đã tồn tại!");
                    req.setAttribute("cate", category);
                    req.getRequestDispatcher(Constant.Path.CATEGORY_EDIT).forward(req, resp);
                    return;
                }

                String fileold = category.getImages();
                category.setCategoryname(categoryname.trim());
                category.setStatus(status);

                String fname = "";
                String uploadPath = Constant.DIR + File.separator + "category";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                try {
                    Part part = req.getPart("images1");
                    if (part != null && part.getSize() > 0) {
                        if (fileold != null && !fileold.startsWith("http") && !fileold.equals("avatar.png")) {
                            deleteFile(uploadPath + File.separator + fileold);
                            deleteFile(Constant.DIR + File.separator + fileold);
                        }
                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = (index > 0) ? filename.substring(index + 1) : "png";
                        fname = System.currentTimeMillis() + "." + ext;
                        part.write(uploadPath + File.separator + fname);
                        category.setImages(fname);
                    } else if (images != null && !images.trim().isEmpty()) {
                        category.setImages(images.trim());
                    } else {
                        category.setImages(fileold);
                    }
                } catch (FileNotFoundException fne) {
                    fne.printStackTrace();
                }

                cateService.update(category);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            if (Files.exists(path)) {
                Files.delete(path);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
