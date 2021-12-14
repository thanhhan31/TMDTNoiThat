package TMDTNoiThat.services;

import java.util.List;

import TMDTNoiThat.entity.Category;

public interface CategoryService {
	List<Category> getAllCategories();
	List<Category> adminGetAllCategories();
	Category getCategoryById(Integer idCategory);
	
	boolean addCategory(String name);
	boolean activeCategory(Integer idCategory);
	boolean deactiveCategory(Integer idCategory);
	boolean deleteCategory(Integer idCategory);
	boolean updateCategory(Integer idCategory, String name, Boolean active);
}
