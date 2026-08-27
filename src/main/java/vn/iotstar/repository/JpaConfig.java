package vn.iotstar.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;
import vn.iotstar.entity.Category;

@PersistenceContext
public class JpaConfig {

    public static EntityManager getEntityManager() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql");
        return factory.createEntityManager();
    }

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