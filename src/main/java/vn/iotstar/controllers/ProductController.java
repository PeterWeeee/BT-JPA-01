package vn.iotstar.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
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
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;

/**
 * ProductController – CRUD quản lý sản phẩm (Admin/Manager).
 * URLs: /admin/products, /admin/product/add, /admin/product/insert,
 *       /admin/product/edit, /admin/product/update, /admin/product/delete
 */
@MultipartConfig
@WebServlet(urlPatterns = {
        "/admin/products",
        "/admin/product/add",
        "/admin/product/insert",
        "/admin/product/edit",
        "/admin/product/update",
        "/admin/product/delete"
})
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            // Danh sách sản phẩm
            String keyword = req.getParameter("keyword");
            List<Product> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = productService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = productService.findAll();
            }
            req.setAttribute("listProduct", list);
            req.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_LIST).forward(req, resp);

        } else if (url.contains("/admin/product/add")) {
            // Form thêm sản phẩm – load danh sách danh mục
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_ADD).forward(req, resp);

        } else if (url.contains("/admin/product/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                Product product = productService.findById(id);
                req.setAttribute("product", product);
                List<Category> categories = categoryService.findAll();
                req.setAttribute("categories", categories);
            }
            req.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_EDIT).forward(req, resp);

        } else if (url.contains("/admin/product/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                try {
                    Product product = productService.findById(id);
                    if (product != null) {
                        String oldImage = product.getImages();
                        productService.delete(id);
                        if (oldImage != null && !oldImage.startsWith("http") && !oldImage.equals("avatar.png")) {
                            deleteFile(Constant.DIR + File.separator + "product" + File.separator + oldImage);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            // --- Thêm sản phẩm mới ---
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceStr    = req.getParameter("price");
            String qtyStr      = req.getParameter("quantity");
            String statusStr   = req.getParameter("status");
            String catIdStr    = req.getParameter("categoryId");
            String images      = req.getParameter("images");

            if (productName == null || productName.trim().isEmpty()) {
                req.setAttribute("alert", "Tên sản phẩm không được để trống!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_ADD).forward(req, resp);
                return;
            }

            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(priceStr != null && !priceStr.isEmpty() ? Double.parseDouble(priceStr) : 0);
            product.setQuantity(qtyStr != null && !qtyStr.isEmpty() ? Integer.parseInt(qtyStr) : 0);
            product.setStatus(statusStr != null ? Integer.parseInt(statusStr) : 1);
            product.setCreatedDate(new Date());

            if (catIdStr != null && !catIdStr.isEmpty()) {
                Category cat = categoryService.findById(Integer.parseInt(catIdStr));
                product.setCategory(cat);
            }

            // Upload ảnh
            String uploadPath = Constant.DIR + File.separator + "product";
            new File(uploadPath).mkdirs();
            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int idx = filename.lastIndexOf(".");
                    String ext = idx > 0 ? filename.substring(idx + 1) : "png";
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    product.setImages(images.trim());
                } else {
                    product.setImages("avatar.png");
                }
            } catch (FileNotFoundException e) {
                product.setImages("avatar.png");
            }

            try {
                productService.insert(product);
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } catch (Exception ex) {
                ex.printStackTrace();
                req.setAttribute("alert", "Loi khi them san pham: " + ex.getMessage());
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_ADD).forward(req, resp);
            }
        }

        if (url.contains("/admin/product/update")) {
            // --- Cập nhật sản phẩm ---
            String idStr       = req.getParameter("productId");
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceStr    = req.getParameter("price");
            String qtyStr      = req.getParameter("quantity");
            String statusStr   = req.getParameter("status");
            String catIdStr    = req.getParameter("categoryId");
            String images      = req.getParameter("images");

            if (idStr == null || idStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            int id = Integer.parseInt(idStr);
            Product product = productService.findById(id);

            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            if (productName == null || productName.trim().isEmpty()) {
                req.setAttribute("alert", "Tên sản phẩm không được để trống!");
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher(Constant.Path.ADMIN_PRODUCT_EDIT).forward(req, resp);
                return;
            }

            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(priceStr != null && !priceStr.isEmpty() ? Double.parseDouble(priceStr) : 0);
            product.setQuantity(qtyStr != null && !qtyStr.isEmpty() ? Integer.parseInt(qtyStr) : 0);
            product.setStatus(statusStr != null ? Integer.parseInt(statusStr) : 1);

            if (catIdStr != null && !catIdStr.isEmpty()) {
                Category cat = categoryService.findById(Integer.parseInt(catIdStr));
                product.setCategory(cat);
            }

            // Upload ảnh mới (nếu có)
            String uploadPath = Constant.DIR + File.separator + "product";
            new File(uploadPath).mkdirs();
            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String oldImg = product.getImages();
                    if (oldImg != null && !oldImg.startsWith("http") && !oldImg.equals("avatar.png")) {
                        deleteFile(uploadPath + File.separator + oldImg);
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int idx = filename.lastIndexOf(".");
                    String ext = idx > 0 ? filename.substring(idx + 1) : "png";
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    product.setImages(images.trim());
                }
                // else giữ ảnh cũ
            } catch (FileNotFoundException e) {
                // giữ ảnh cũ
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    private static void deleteFile(String filePath) {
        try {
            Path p = Paths.get(filePath);
            if (Files.exists(p)) Files.delete(p);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
