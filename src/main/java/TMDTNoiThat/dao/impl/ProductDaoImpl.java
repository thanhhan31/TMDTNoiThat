package TMDTNoiThat.dao.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.CriteriaUpdate;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.ListJoin;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.ProductDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.Category_;
import TMDTNoiThat.entity.Comment;
import TMDTNoiThat.entity.ProductImage;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.entity.Product_;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.entity.User_;
import TMDTNoiThat.utils.ConstantValue;
import TMDTNoiThat.utils.MyUtils;

public class ProductDaoImpl implements ProductDao {
	@Override
	public List<Product> getProducts(Integer idCategory, String searchName, Integer sortType, int start, int count) { // for buyer only
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Product> cq = cb.createQuery(Product.class);
		Root<Product> rootEntry = cq.from(Product.class);
		cq.select(rootEntry);

		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (idCategory != null) {
			cond.add(cb.equal(rootEntry.get(Product_.category).get(Category_.id), idCategory));
		}
		
		if (searchName != null) {
			cond.add(cb.like(rootEntry.get(Product_.name), "%" + searchName + "%"));
		}
		
		cond.add(cb.and(
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true),
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED),
				cb.gt(rootEntry.get(Product_.availableQuantity), 0)));
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);
		
		if (sortType != null) {
			if (sortType == ConstantValue.SORT_PRODUCT_PRICE_DESC) {
				cq.orderBy(cb.desc(rootEntry.get(Product_.price)));
			}
			else if (sortType == ConstantValue.SORT_PRODUCT_PRICE_ASC) {
				cq.orderBy(cb.asc(rootEntry.get(Product_.price)));
			}
			else if (sortType == ConstantValue.SORT_PRODUCT_MOST_SOLD) {
				cq.orderBy(cb.desc(rootEntry.get(Product_.nsold)));
			}
		}
		
		List<Product> ret = em.createQuery(cq)
				.setFirstResult(start)
				.setMaxResults(count)
				.getResultList();
		em.close();

		return ret;
	}
	
	@Override
	public Long countProducts(Integer idCategory, String searchName) { // for buyer only
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<Product> rootEntry = cq.from(Product.class);
		cq.select(cb.count(rootEntry));
		
		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (idCategory != null) {
			cond.add(cb.equal(rootEntry.get(Product_.category).get(Category_.id), idCategory));
		}
		
		if (searchName != null) {
			cond.add(cb.like(rootEntry.get(Product_.name), "%" + searchName + "%"));
		}
		
		cond.add(cb.and(
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true),
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED),
				cb.gt(rootEntry.get(Product_.availableQuantity), 0)));
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);
		
		Long ret = em.createQuery(cq).getSingleResult();
		em.close();
		
		return ret;
	}
	
	@Override
	public List<Product> sellerGetProducts(Integer idUser, Integer idCategory, Integer status, Boolean outOfStock, int start, int count) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Product> cq = cb.createQuery(Product.class);
		Root<Product> rootEntry = cq.from(Product.class);
		cq.select(rootEntry);
		
		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (idUser != null) {
			cond.add(cb.equal(rootEntry.get(Product_.user).get(User_.id), idUser));
		}
		
		if (idCategory != null) {
			cond.add(cb.equal(rootEntry.get(Product_.category).get(Category_.id), idCategory));
		}
		
		if (status != null) {
			if (status == ConstantValue.PRODUCT_DISABLED_ADMIN) {
				cond.add(cb.or(cb.equal(rootEntry.get(Product_.active), status),
						cb.equal(rootEntry.get(Product_.category).get(Category_.active), false)));
			}
			else {
				cond.add(cb.equal(rootEntry.get(Product_.active), status));
			}
		}
		
		if (outOfStock != null) {
			if (outOfStock.booleanValue()) {
				cond.add(cb.equal(rootEntry.get(Product_.availableQuantity), 0));
			}
			else {
				cond.add(cb.gt(rootEntry.get(Product_.availableQuantity), 0));
			}
		}
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);

		List<Product> ret = em.createQuery(cq)
				.setFirstResult(start)
				.setMaxResults(count)
				.getResultList();
		
		em.close();
		return ret;
	}
	
	@Override
	public Long sellerCountProducts(Integer idUser, Integer idCategory, Integer status, Boolean outOfStock) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<Product> rootEntry = cq.from(Product.class);
		cq.select(cb.count(rootEntry));
		
		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (idUser != null) {
			cond.add(cb.equal(rootEntry.get(Product_.user).get(User_.id), idUser));
		}
		
		if (idCategory != null) {
			cond.add(cb.equal(rootEntry.get(Product_.category).get(Category_.id), idCategory));
		}
		
		if (status != null) {
			cond.add(cb.equal(rootEntry.get(Product_.active), status));
		}
		
		if (outOfStock != null) {
			if (outOfStock.booleanValue()) {
				cond.add(cb.equal(rootEntry.get(Product_.availableQuantity), 0));
			}
			else {
				cond.add(cb.gt(rootEntry.get(Product_.availableQuantity), 0));
			}
		}
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);
		
		Long ret = em.createQuery(cq).getSingleResult();
		em.close();
		
		return ret;
	}
	
	@Override
	public List<Product> getTopNsoldProducts(Integer top) { //for buyer only
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Product> cq = cb.createQuery(Product.class);
		Root<Product> rootEntry = cq.from(Product.class);
		CriteriaQuery<Product> all = cq.select(rootEntry);
		
		cq.where(cb.and(
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED), 
				cb.gt(rootEntry.get(Product_.availableQuantity), 0), 
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true)
				));
		all.orderBy(cb.desc(rootEntry.get(Product_.nsold)));
		
		List<Product> ret = em.createQuery(all)
								.setFirstResult(0)
								.setMaxResults(top)
								.getResultList();
		em.close();

		return ret;
	}

	@Override
	public List<Product> getTopNvisitProducts(Integer top) { //for buyer only
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Product> cq = cb.createQuery(Product.class);
		Root<Product> rootEntry = cq.from(Product.class);
		
		cq.select(rootEntry);
		cq.where(cb.and(
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED), 
				cb.gt(rootEntry.get(Product_.availableQuantity), 0), 
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true)
				));
		cq.orderBy(cb.desc(rootEntry.get(Product_.nvisit)));
		
		List<Product> ret = em.createQuery(cq)
								.setFirstResult(0)
								.setMaxResults(top)
								.getResultList();
		em.close();

		return ret;
	}

	@Override
	public List<Product> getTopNcommentProducts(Integer top) { //for buyer only
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Tuple> cq = cb.createTupleQuery();
		Root<Product> rootEntry = cq.from(Product.class);
		
		ListJoin<Product, Comment> comments = rootEntry.join(Product_.comments, JoinType.LEFT);
		
		cq.multiselect(rootEntry.get(Product_.id), cb.count(comments));
		cq.where(cb.and(
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED), 
				cb.gt(rootEntry.get(Product_.availableQuantity), 0), 
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true)
				));
		cq.groupBy(rootEntry.get(Product_.id));
		cq.orderBy(cb.desc(cb.count(comments)));
		
		List<Tuple> sret = em.createQuery(cq)
								.setFirstResult(0)
								.setMaxResults(top)
								.getResultList();
		
		List<Product> ret = new ArrayList<Product>();
		for (Tuple t : sret) {
			ret.add(em.find(Product.class, t.get(0)));
		}
		
		em.close();
		
		return ret;
	}
	
	@Override
	public List<Product> getTopLastedProducts(Integer top) { //for buyer only
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Product> cq = cb.createQuery(Product.class);
		Root<Product> rootEntry = cq.from(Product.class);
		
		cq.select(rootEntry);
		cq.where(cb.and(
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED), 
				cb.gt(rootEntry.get(Product_.availableQuantity), 0), 
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true)
				));
		cq.orderBy(cb.desc(rootEntry.get(Product_.createTime)));
		
		List<Product> ret = em.createQuery(cq)
								.setFirstResult(0)
								.setMaxResults(top)
								.getResultList();
		em.close();

		return ret;
	}
	
	@Override
	public List<Product> getRandomProductsByCategory(Integer idCategory, Integer count, Integer exceptIdProduct) { //for buyer only
		int exceptId = exceptIdProduct == null ? -1 : exceptIdProduct.intValue();
		int pcount =  countProducts(idCategory, null).intValue();
		if (pcount - 1 < count)
			count = pcount - 1;
		
		List<Product> ret = new ArrayList<Product>();
		List<Integer> randPost = new ArrayList<Integer>();
		Random rand = new Random();
		
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Product> cq = cb.createQuery(Product.class);
		Root<Product> rootEntry = cq.from(Product.class);
		
		cq.select(rootEntry);
		cq.where(cb.and(
				cb.equal(rootEntry.get(Product_.active), ConstantValue.PRODUCT_ENABLED),
				cb.gt(rootEntry.get(Product_.availableQuantity), 0),
				cb.equal(rootEntry.get(Product_.category).get(Category_.id), idCategory),
				cb.equal(rootEntry.get(Product_.category).get(Category_.active), true)
				));
		
		for (int i = 0; i < count; i++) {
			
			while (true) {
				int p = rand.nextInt(pcount);
				while (randPost.contains(p)) {
					p = rand.nextInt(pcount);
				}
				Product tmp = em.createQuery(cq).setFirstResult(p)
									.setMaxResults(1)
									.getSingleResult();
				if (tmp.getId() != exceptId) {
					ret.add(tmp);
					randPost.add(p);
					break;
				}
			}
		}
		
		em.close();
		return ret;
	}
	
	@Override
	public Product getProductById(Integer idProduct) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		Product ret = em.find(Product.class, idProduct);
		em.close();
		return ret;
	}

	@Override
	public boolean addProduct(Integer idCategory, String name, BigDecimal price, String description, Integer active, Integer availableQuantity, Integer idUser, List<String> imageLinks) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		Product p = new Product();
		p.setCategory(new CategoryDaoImpl().getCategoryById(idCategory));
		p.setName(name);
		p.setPrice(price);
		p.setDescription(description);
		p.setCreateTime(MyUtils.getCurrentTime());
		p.setActive(active);
		p.setUser(em.getReference(User.class, idUser));
		p.setAvailableQuantity(availableQuantity);
		
		p.setNsold(0);
		p.setNvisit(0);

		try {
			em.getTransaction().begin();
			em.persist(p);
			if (imageLinks != null) {
				em.flush();
				for (String imageLink : imageLinks) {
					ProductImage pimg = new ProductImage();
					pimg.setProduct(p);
					pimg.setImageLink(imageLink);
					em.persist(pimg);
				}
			}
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
	public boolean updateProduct(Integer idProduct, Integer idCategory, String name, BigDecimal price, String description, Integer nvisit, Integer nsold, Integer active, Integer availableQuantity) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();

		CriteriaUpdate<Product> d = cb.createCriteriaUpdate(Product.class);
		Root<Product> rootEntry = d.from(Product.class);
		if (idCategory != null)
			d.set(rootEntry.get(Product_.category).get(Category_.id), idCategory);
		if (name != null)
			d.set(rootEntry.get(Product_.name), name);
		if (price != null)
			d.set(rootEntry.get(Product_.price), price);
		if (description != null)
			d.set(rootEntry.get(Product_.description), description);
		if (nvisit != null)
			d.set(rootEntry.get(Product_.nvisit), nvisit);
		if (nsold != null)
			d.set(rootEntry.get(Product_.nsold), nsold);
		if (active != null)
			d.set(rootEntry.get(Product_.active), active);
		if (availableQuantity != null)
			d.set(rootEntry.get(Product_.availableQuantity), availableQuantity);
		
		d.where(cb.equal(rootEntry.get(Product_.id), idProduct));
		
		em.getTransaction().begin();
		if (em.createQuery(d).executeUpdate() != 0) {
			ret = true;
		}
		em.getTransaction().commit();
		em.close();
		
		return ret;
	}

	@Override
	public boolean deleteProduct(Integer idProduct) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		
		CriteriaDelete<Product> d = cb.createCriteriaDelete(Product.class);
		Root<Product> rootEntry = d.from(Product.class);
		d.where(cb.equal(rootEntry.get(Product_.id), idProduct));
		
		em.getTransaction().begin();
		if (em.createQuery(d).executeUpdate() != 0) {
			ret = true;
		}
		em.getTransaction().commit();
		em.close();
		
		return ret;
	}
}
