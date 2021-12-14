package TMDTNoiThat.dao.impl;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.CartDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.CartItem_;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.entity.Product_;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.entity.User_;

public class CartDaoImpl implements CartDao {	
	@Override
	public BigDecimal getTotalCartPrice(Integer idUser) {
		BigDecimal itemPrice = BigDecimal.ZERO;
		BigDecimal totalPrice = BigDecimal.ZERO;
		List<CartItem> cart = getUserCart(idUser);
		for (CartItem c : cart) {
			itemPrice = c.getProduct().getUnitPrice().multiply(BigDecimal.valueOf(c.getQuantity()));
			totalPrice = totalPrice.add(itemPrice);
		}
		return totalPrice;
	}

	@Override
	public Integer getTotalCartQuantity(Integer idUser) { //only on available product
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Integer> cq = cb.createQuery(Integer.class);
		
		Root<CartItem> rootEntry = cq.from(CartItem.class);
		
		cq.select(cb.sum(rootEntry.get(CartItem_.quantity)));
		cq.where(cb.and(cb.le(rootEntry.get(CartItem_.quantity), rootEntry.get(CartItem_.product).get(Product_.availableQuantity)),
				cb.equal(rootEntry.get(CartItem_.user).get(User_.id), idUser)));
		cq.groupBy(rootEntry.get(CartItem_.user).get(User_.id)); 
		
		try {
	    	return em.createQuery(cq).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	    finally {
	    	em.close();
	    }
	}

	@Override
	public List<CartItem> getUserCart(Integer idUser) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
	    CriteriaQuery<CartItem> cq = cb.createQuery(CartItem.class);
	    
	    Root<CartItem> rootEntry = cq.from(CartItem.class);
	    CriteriaQuery<CartItem> all = cq.select(rootEntry);
	    all.where(cb.equal(rootEntry.get(CartItem_.user).get(User_.id), idUser));
	    
	    List<CartItem> ret = em.createQuery(all).getResultList();
	    em.close();
	    
	    return ret;
	}
	
	@Override
	public boolean adjustProductCartQuantity(Integer idUser, Integer idProduct, int new_quantity) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		try {
			CartItem productCart = getUserProductCart(idUser, idProduct);
			if (productCart != null && new_quantity <= productCart.getProduct().getAvailableQuantity()) {
				productCart.setQuantity(new_quantity);
				em.getTransaction().begin();
				em.merge(productCart);
				em.getTransaction().commit();
				return true;
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			em.close();
		}
	}

	@Override
	public boolean addProductCart(Integer idUser, Integer idProduct, int quantity) {
		if (quantity > new ProductDaoImpl().getProductById(idProduct).getAvailableQuantity()) {
			return false;
		}
		
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		try {
			CartItem userProductCart = getUserProductCart(idUser, idProduct);
			em.getTransaction().begin();
		    if (userProductCart == null) {
		    	CartItem n = new CartItem();
		    	n.setProduct(em.getReference(Product.class, idProduct));
		    	n.setUser(em.getReference(User.class, idUser));
		    	n.setQuantity(quantity);
		    	em.persist(n);
		    }
		    else {
		    	userProductCart.setQuantity(userProductCart.getQuantity() + quantity);
		    	em.merge(userProductCart);
		    }
		    em.getTransaction().commit();
		    return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			em.close();
		}
	}

	@Override
	public boolean removeProductCart(Integer idUser, Integer idProduct) {		
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		
		CriteriaDelete<CartItem> d = cb.createCriteriaDelete(CartItem.class);
		Root<CartItem> rootEntry = d.from(CartItem.class);

		d.where(cb.and(cb.equal(rootEntry.get(CartItem_.user).get(User_.id), idUser),
				cb.equal(rootEntry.get(CartItem_.product).get(Product_.id), idProduct)));
		
		em.getTransaction().begin();
		if (em.createQuery(d).executeUpdate() != 0) {
			ret = true;
		}
		em.getTransaction().commit();
		em.close();
		
		return ret;
	}
	
	private CartItem getUserProductCart(Integer idUser, Integer idProduct) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
	    CriteriaQuery<CartItem> cq = cb.createQuery(CartItem.class);
	    
	    Root<CartItem> rootEntry = cq.from(CartItem.class);
	    CriteriaQuery<CartItem> all = cq.select(rootEntry);

	    all.where(cb.and(cb.equal(rootEntry.get(CartItem_.user).get(User_.id), idUser),
	    		cb.equal(rootEntry.get(CartItem_.product).get(Product_.id), idProduct)));
	    
	    try {
	    	CartItem ret = em.createQuery(all).getSingleResult();
	    	return ret;
		} catch (NoResultException e) {
			return null;
		}
	    finally {
	    	em.close();
	    }
	}
}
