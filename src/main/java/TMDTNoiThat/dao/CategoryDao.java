package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.Category;

public interface CategoryDao {
	List<Category> getAllCategories(Boolean isBuyer);
	Category getCategoryById(Integer idCategory);
	
	boolean addCategory(String name);
	boolean setStatusCategory(Integer idCategory, Boolean active);
	boolean deleteCategory(Integer idCategory);
	boolean updateCategory(Integer idCategory, String name, Boolean active);
}
