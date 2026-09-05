package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;

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
 * ProductListController – Trang /product: Hiển thị tất cả sản phẩm, phân trang 6 SP/trang.
 */
@WebServlet(urlPatterns = { "/product" })
public class ProductListController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6;

    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Lấy số trang hiện tại (mặc định là 1)
        int currentPage = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam.trim());
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Tìm kiếm nếu có keyword
        String keyword = req.getParameter("keyword");
        List<Product> products;
        int totalPages;

        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productService.searchByName(keyword.trim());
            totalPages = (int) Math.ceil((double) products.size() / PAGE_SIZE);
            // Phân trang thủ công cho kết quả tìm kiếm
            int from = (currentPage - 1) * PAGE_SIZE;
            int to = Math.min(from + PAGE_SIZE, products.size());
            if (from < products.size()) {
                products = products.subList(from, to);
            } else {
                products = java.util.Collections.emptyList();
            }
            req.setAttribute("keyword", keyword.trim());
        } else {
            products = productService.findAllPaged(currentPage, PAGE_SIZE);
            totalPages = productService.getTotalPages(PAGE_SIZE);
        }

        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        req.setAttribute("products", products);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", PAGE_SIZE);

        req.getRequestDispatcher(Constant.Path.PRODUCT_LIST).forward(req, resp);
    }
}
