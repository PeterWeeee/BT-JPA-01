package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.constant.Constant;
import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

/**
 * ProductDetailController – Trang chi tiết sản phẩm.
 * URL: /product/detail?id=xxx
 */
@WebServlet(urlPatterns = { "/product/detail" })
public class ProductDetailController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            Product product = productService.findById(id);
            if (product == null) {
                req.setAttribute("errorMessage", "Không tìm thấy sản phẩm!");
                req.getRequestDispatcher(Constant.Path.ERROR).forward(req, resp);
                return;
            }
            req.setAttribute("product", product);
            req.getRequestDispatcher(Constant.Path.PRODUCT_DETAIL).forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}
