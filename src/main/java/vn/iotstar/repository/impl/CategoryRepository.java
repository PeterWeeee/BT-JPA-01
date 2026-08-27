package vn.iotstar.repository.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.entity.Category;
import vn.iotstar.repository.ICategoryRepository;
import vn.iotstar.repository.JpaConfig;

public class CategoryRepository implements ICategoryRepository{
	@Override
	public void insert(Category category) {


		 EntityManager enma = JpaConfig.getEntityManager();


		 EntityTransaction trans = enma.getTransaction();


		 try {


		 trans.begin();


		 enma.persist(category);//insert vào bảng


		 trans.commit();


		 } catch (Exception e) {


		 e.printStackTrace();


		 trans.rollback();


		 throw e;


		 }finally {


		 enma.close();


		 }
}
	
	@Override


	 public Category findByCategoryname(String name) throws Exception {


	 EntityManager enma = JpaConfig.getEntityManager();


	 


	 String jpql = "SELECT c FROM Category c WHERE c.categoryname =:catename";


	 try {


	 


	 TypedQuery<Category> query= enma.createQuery(jpql, Category.class);


	 query.setParameter("catename", name);


	 Category category= query.getSingleResult();


	 if(category==null) {


	 throw new Exception("Category Name đã tồn tại");


	 }


	 return category;


	 } finally {


	 enma.close();


	 } 
}
}
