package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.CriteriaUpdate;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.CategoryDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.Category;
import TMDTNoiThat.entity.Category_;

public class CategoryDaoImpl implements CategoryDao {

	@Override
	public List<Category> getAllCategories(Boolean isBuyer) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Category> cq = cb.createQuery(Category.class);
		Root<Category> rootEntry = cq.from(Category.class);
		
		cq.select(rootEntry);
		
		if (isBuyer)
			cq.where(cb.equal(rootEntry.get(Category_.active), true));

		List<Category> ret = em.createQuery(cq).getResultList();
		em.close();

		return ret;
	}

	@Override
	public Category getCategoryById(Integer idCategory) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Category> cq = cb.createQuery(Category.class);
		Root<Category> rootEntry = cq.from(Category.class);
		CriteriaQuery<Category> c = cq.select(rootEntry).where(cb.equal(rootEntry.get(Category_.id), idCategory));

		try {
			return em.createQuery(c).getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	@Override
	public boolean addCategory(String name) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		Category c = new Category();
		c.setName(name);
		c.setActive(true);

		try {
			em.getTransaction().begin();
			em.persist(c);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	@Override
	public boolean setStatusCategory(Integer idCategory, Boolean active) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		
		CriteriaUpdate<Category> d = cb.createCriteriaUpdate(Category.class);
		Root<Category> rootEntry = d.from(Category.class);
		d.set(rootEntry.get(Category_.active), active);
		d.where(cb.equal(rootEntry.get(Category_.id), idCategory));
		
		em.getTransaction().begin();
		if (em.createQuery(d).executeUpdate() != 0) {
			ret = true;
		}
		em.getTransaction().commit();
		em.close();
		
		return ret;
	}
	
	@Override
	public boolean deleteCategory(Integer idCategory) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		
		CriteriaDelete<Category> d = cb.createCriteriaDelete(Category.class);
		Root<Category> rootEntry = d.from(Category.class);
		d.where(cb.equal(rootEntry.get(Category_.id), idCategory));
		
		em.getTransaction().begin();
		if (em.createQuery(d).executeUpdate() != 0) {
			ret = true;
		}
		em.getTransaction().commit();
		em.close();
		
		return ret;
	}

	@Override
	public boolean updateCategory(Integer idCategory, String name, Boolean active) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		try {
			Category c = em.find(Category.class, idCategory);
			if (name != null)
				c.setName(name);
			if (active != null)
				c.setActive(active);
			em.getTransaction().begin();
			em.merge(c);
			em.getTransaction().commit();
			ret = true;
		}
		catch (Exception e) {
			ret = false;
		}
		
		em.close();
		return ret;
	}
}
