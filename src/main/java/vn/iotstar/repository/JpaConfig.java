package vn.iotstar.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import vn.iotstar.entity.Category;

/**
 * JpaConfig – cung cấp EntityManager từ một EntityManagerFactory dùng chung (singleton).
 *
 * LỖI đã sửa:
 *  - [LỖI 1] EntityManagerFactory PHẢI được tạo một lần duy nhất (singleton).
 *            Tạo mới mỗi lần gọi sẽ gây rò rỉ tài nguyên nghiêm trọng.
 *  - [LỖI 2] Đổi tên persistence-unit từ "jpa-hibernate-mysql" → "jpa-hibernate-sqlserver"
 *            để phản ánh đúng database thực tế là SQL Server.
 *  - [LỖI 9] Xóa @PersistenceContext đặt sai trên class (annotation này chỉ dùng
 *            để inject EntityManager vào một field, không dùng cho class).
 */
public class JpaConfig {

    // Singleton: chỉ khởi tạo một lần khi class được load
    private static final EntityManagerFactory FACTORY =
            Persistence.createEntityManagerFactory("jpa-hibernate-sqlserver");

    /**
     * Trả về một EntityManager mới từ factory dùng chung.
     * Người gọi có trách nhiệm đóng EntityManager sau khi dùng xong.
     */
    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }

    /** Test nhanh kết nối JPA */
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        Category cate = new Category();
        cate.setCategoryname("Iphone");
        cate.setImages("abc.jpg");
        cate.setStatus(1);

        try {
            trans.begin();
            enma.persist(cate);
            trans.commit();
            System.out.println("Thêm Category thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }
}