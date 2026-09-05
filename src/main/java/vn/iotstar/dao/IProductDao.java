package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id) throws Exception;
    Product findById(int id);
    List<Product> findAll();

    /** Lấy 10 sản phẩm mới nhất (status=1, sắp xếp theo createdDate DESC) */
    List<Product> findTop10Latest();

    /** Phân trang: lấy sản phẩm theo trang (1-indexed) */
    List<Product> findAllPaged(int page, int pageSize);

    /** Tổng số sản phẩm (status=1) */
    long countAll();

    /** Tìm sản phẩm theo tên (tìm kiếm) */
    List<Product> searchByName(String keyword);
}
