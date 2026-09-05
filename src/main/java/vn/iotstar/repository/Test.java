package vn.iotstar.repository;

import java.util.Date;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;

public class Test {

    public static void main(String[] args) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        Category cate = new Category();
        cate.setCategoryname("Iphone");
        cate.setImages("abc.jpg");
        cate.setStatus(1);

        Video video = new Video();
        video.setVideoId("v01");
        video.setTitle("test");
        video.setActive(1);
        video.setDescription("Video test JPA");
        video.setPoster("poster.jpg");
        video.setViews(100);
        video.setCategory(cate);

        User user = new User();
        user.setUserName("testadmin");
        user.setPassWord("123");
        user.setFullName("Test Admin");
        user.setEmail("testadmin@iotstar.vn");
        user.setRoleid(1);
        user.setPhone("0901234567");
        user.setCreatedDate(new Date());

        try {
            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            enma.persist(user);
            trans.commit();
            System.out.println(">>> Cấu hình và Test JPA thành công: Đã lưu Category, Video và User vào Database!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enma.close();
        }
    }
}
