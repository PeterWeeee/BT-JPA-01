package vn.iotstar.dao.impl;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // Re-attach Category trong cung EntityManager de tranh "detached entity passed to persist"
            if (product.getCategory() != null && product.getCategory().getCategoryId() > 0) {
                vn.iotstar.entity.Category managedCat = em.find(vn.iotstar.entity.Category.class,
                        product.getCategory().getCategoryId());
                product.setCategory(managedCat);
            }
            em.persist(product);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.err.println("[ProductDaoImpl] Loi insert: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // Re-attach Category trong cung EntityManager de tranh "detached entity"
            if (product.getCategory() != null && product.getCategory().getCategoryId() > 0) {
                vn.iotstar.entity.Category managedCat = em.find(vn.iotstar.entity.Category.class,
                        product.getCategory().getCategoryId());
                product.setCategory(managedCat);
            }
            em.merge(product);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.err.println("[ProductDaoImpl] Loi update: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Product p = em.find(Product.class, id);
            if (p != null) {
                em.remove(p);
            } else {
                throw new Exception("Khong tim thay san pham co id = " + id);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            // Dung JOIN FETCH de load Category ngay trong cung query, tranh LazyInitializationException
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.productId = :id";
            TypedQuery<Product> q = em.createQuery(jpql, Product.class);
            q.setParameter("id", id);
            List<Product> list = q.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            System.err.println("[ProductDaoImpl] Loi findById: " + e.getMessage());
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            // LEFT JOIN FETCH p.category: eager-load danh muc de tranh LazyInitializationException
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category ORDER BY p.createdDate DESC";
            TypedQuery<Product> q = em.createQuery(jpql, Product.class);
            return q.getResultList();
        } catch (Exception e) {
            System.err.println("[ProductDaoImpl] Loi findAll: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findTop10Latest() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.status = 1 ORDER BY p.createdDate DESC";
            TypedQuery<Product> q = em.createQuery(jpql, Product.class);
            q.setMaxResults(10);
            return q.getResultList();
        } catch (Exception e) {
            System.err.println("[ProductDaoImpl] Loi findTop10Latest: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAllPaged(int page, int pageSize) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            // Buoc 1: lay danh sach id phan trang
            String idJpql = "SELECT p.productId FROM Product p WHERE p.status = 1 ORDER BY p.createdDate DESC";
            TypedQuery<Integer> idQuery = em.createQuery(idJpql, Integer.class);
            idQuery.setFirstResult((page - 1) * pageSize);
            idQuery.setMaxResults(pageSize);
            List<Integer> ids = idQuery.getResultList();

            if (ids.isEmpty()) return new ArrayList<>();

            // Buoc 2: load san pham + category theo id
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.productId IN :ids ORDER BY p.createdDate DESC";
            TypedQuery<Product> q = em.createQuery(jpql, Product.class);
            q.setParameter("ids", ids);
            return q.getResultList();
        } catch (Exception e) {
            System.err.println("[ProductDaoImpl] Loi findAllPaged: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Product p WHERE p.status = 1";
            TypedQuery<Long> q = em.createQuery(jpql, Long.class);
            Long result = q.getSingleResult();
            return result != null ? result : 0L;
        } catch (Exception e) {
            System.err.println("[ProductDaoImpl] Loi countAll: " + e.getMessage());
            return 0L;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> searchByName(String keyword) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.productName LIKE :kw ORDER BY p.createdDate DESC";
            TypedQuery<Product> q = em.createQuery(jpql, Product.class);
            q.setParameter("kw", "%" + keyword + "%");
            return q.getResultList();
        } catch (Exception e) {
            System.err.println("[ProductDaoImpl] Loi searchByName: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
