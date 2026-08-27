package vn.iotstar.repository;

import vn.iotstar.entity.Category;

public interface ICategoryRepository {

	void insert(Category category);

	Category findByCategoryname(String name) throws Exception;

}
