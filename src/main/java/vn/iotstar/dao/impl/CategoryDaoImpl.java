package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;
import vn.iotstar.repository.JpaConfig;

public class CategoryDaoImpl implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
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

    /**
     * [LỖI 3+4 đã sửa] Không dùng enma.merge(category) trực tiếp trên detached entity.
     *
     * Vấn đề cũ: Category được load bởi EM #1 (đã đóng), sau đó truyền vào đây.
     * Khi merge() detached entity có @OneToMany(cascade=ALL, orphanRemoval=true),
     * danh sách videos sẽ là empty → JPA XÓA TOÀN BỘ Video của category đó.
     *
     * Giải pháp: load managed entity trong cùng EM này, chỉ set các field cần update,
     * không động đến collection videos → an toàn.
     */
    @Override
    public void update(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            // Load managed entity trong cùng EM này
            Category managed = enma.find(Category.class, category.getCategoryId());
            if (managed != null) {
                managed.setCategoryname(category.getCategoryname());
                managed.setImages(category.getImages());
                managed.setStatus(category.getStatus());
                // Không set videos → tránh cascade orphanRemoval xóa nhầm dữ liệu
            }
            trans.commit();
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

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, cateid);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy Category với id = " + cateid);
            }
            trans.commit();
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

    @Override
    public Category findById(int cateid) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Category.class, cateid);
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE c.categoryname = :catename";
        try {
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catename", name);
            List<Category> list = query.getResultList();
            if (list == null || list.isEmpty()) {
                return null;
            }
            return list.get(0);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> searchByName(String catname) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE c.categoryname LIKE :catname";
        try {
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catname", "%" + catname + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    /**
     * [LỖI 5 đã sửa] Phân trang dùng chỉ số 0-based (trang đầu = page 0).
     * Công thức: setFirstResult(page * pagesize)
     *   - page=0 → bỏ qua 0 bản ghi (trang đầu tiên) ✓
     *   - page=1 → bỏ qua pagesize bản ghi (trang thứ hai) ✓
     * KHÔNG truyền page=1 để lấy trang đầu, sẽ mất pagesize bản ghi đầu tiên.
     */
    @Override
    public List<Category> findAll(int page, int pagesize) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult(page * pagesize); // page là 0-based
            query.setMaxResults(pagesize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(c) FROM Category c";
        try {
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }
}
