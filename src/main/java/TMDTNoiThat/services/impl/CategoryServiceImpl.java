package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.CategoryDao;
import TMDTNoiThat.dao.impl.CategoryDaoImpl;
import TMDTNoiThat.entity.Category;
import TMDTNoiThat.services.CategoryService;

public class CategoryServiceImpl implements CategoryService {
	CategoryDao c = new CategoryDaoImpl();

	@Override
	public List<Category> getAllCategories() {
		return c.getAllCategories(true);
	}
	
	public List<Category> adminGetAllCategories() {
		return c.getAllCategories(false);
	}

	@Override
	public Category getCategoryById(Integer idCategory) {
		return c.getCategoryById(idCategory);
	}

	@Override
	public boolean addCategory(String name) {
		return c.addCategory(name);
	}

	@Override
	public boolean activeCategory(Integer idCategory) {
		return c.setStatusCategory(idCategory, true);
	}

	@Override
	public boolean deactiveCategory(Integer idCategory) {
		return c.setStatusCategory(idCategory, false);
	}

	@Override
	public boolean deleteCategory(Integer idCategory) {
		return c.deleteCategory(idCategory);
	}

	@Override
	public boolean updateCategory(Integer idCategory, String name, Boolean active) {
		return c.updateCategory(idCategory, name, active);
	}
}
