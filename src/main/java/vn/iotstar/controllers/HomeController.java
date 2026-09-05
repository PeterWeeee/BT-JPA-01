package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.constant.Constant;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/home", "/user/home" })
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User account = (session != null) ? (User) session.getAttribute(Constant.SESSION_ACCOUNT) : null;
        req.setAttribute("account", account);

        // Lấy 10 sản phẩm mới nhất để hiển thị trang chủ
        List<Product> latestProducts = productService.findTop10Latest();
        req.setAttribute("latestProducts", latestProducts);

        req.getRequestDispatcher(Constant.Path.HOME).forward(req, resp);
    }
}
