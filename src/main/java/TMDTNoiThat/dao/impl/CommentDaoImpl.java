package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.CommentDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.Comment;
import TMDTNoiThat.entity.Comment_;
import TMDTNoiThat.entity.Product_;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.utils.MyUtils;

public class CommentDaoImpl implements CommentDao {

	@Override
	public List<Comment> getProductComments(Integer idProduct) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
	    CriteriaQuery<Comment> cq = cb.createQuery(Comment.class);
	    Root<Comment> root = cq.from(Comment.class);
	    cq.where(cb.equal(root.get(Comment_.product).get(Product_.id), idProduct));
	    cq.orderBy(cb.desc(root.get(Comment_.time)));
	    
	    List<Comment> ret = em.createQuery(cq).getResultList();
	    em.close();
	    
	    return ret;
	}

	@Override
	public Long countProductComments(Integer idProduct) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder qb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = qb.createQuery(Long.class);
		Root<Comment> root = cq.from(Comment.class);
		cq.select(qb.count(root));
		cq.where(qb.equal(root.get(Comment_.product).get(Product_.id), idProduct));
		
		Long ret = em.createQuery(cq).getSingleResult();
		em.close();
		
		return ret;
	}

	@Override
	public boolean addProductComment(User user, Integer idProduct, String comment, Integer rating) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		Comment c = new Comment();
		c.setUser(user);
		c.setProduct(new ProductDaoImpl().getProductById(idProduct));
		c.setComment(comment);
		c.setRating(rating);
		c.setTime(MyUtils.getCurrentTime());

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
}
