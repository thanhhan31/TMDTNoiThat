package TMDTNoiThat.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.UserDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.entity.UserRole;
import TMDTNoiThat.entity.User_;
import TMDTNoiThat.entity.UserRole_;
import TMDTNoiThat.utils.MyUtils;

public class UserDaoImpl implements UserDao {

	@Override
	public List<User> getUsers(Integer idRole, String searchName, Boolean active, Integer start, Integer count) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> cq = cb.createQuery(User.class);
		Root<User> rootEntry = cq.from(User.class);
		
		cq.select(rootEntry);
		
		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (idRole != null) {
			cond.add(cb.equal(rootEntry.get(User_.userRole).get(UserRole_.id), idRole));
		}
		
		if (searchName != null) {
			cond.add(cb.like(rootEntry.get(User_.username), "%" + searchName + "%"));
		}
		
		if (active != null) {
			cond.add(cb.equal(rootEntry.get(User_.active), active));
		}
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);

		List<User> ret = 
				em.createQuery(cq)
				.setFirstResult(start)
				.setMaxResults(count)
				.getResultList();
		em.close();

		return ret;
	}
	
	@Override
	public Long countUsers(Integer idRole, String searchName, Boolean active) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<User> rootEntry = cq.from(User.class);
		
		cq.select(cb.count(rootEntry));
		
		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (idRole != null) {
			cond.add(cb.equal(rootEntry.get(User_.userRole).get(UserRole_.id), idRole));
		}
		
		if (searchName != null) {
			cond.add(cb.like(rootEntry.get(User_.username), "%" + searchName + "%"));
		}
		
		if (active != null) {
			cond.add(cb.equal(rootEntry.get(User_.active), active));
		}
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);

		Long ret = em.createQuery(cq).getSingleResult();
		em.close();

		return ret;
	}
	
	@Override
	public User getUser(Integer idUser) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> cq = cb.createQuery(User.class);
		Root<User> rootEntry = cq.from(User.class);
		CriteriaQuery<User> c = cq.select(rootEntry);
		c.where(cb.equal(rootEntry.get(User_.id), idUser));
		
		try {
			User ret = em.createQuery(c).getSingleResult();
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	@Override
	public User getUser(String email, String password) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> cq = cb.createQuery(User.class);
		Root<User> rootEntry = cq.from(User.class);
		CriteriaQuery<User> c = cq.select(rootEntry);
		
		c.where(cb.and(cb.equal(rootEntry.get(User_.email), email),
				cb.equal(rootEntry.get(User_.password), MyUtils.hash_password_SHA256(password, email))));

		try {
			User ret = em.createQuery(c).getSingleResult();
			return ret;
		}
		catch (NoResultException e) {
			return null;
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	@Override
	public boolean createUser(Integer idRole, String username, String password, String phone, String email, String avatar, Boolean active) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		try {
			User newUser = new User();
			newUser.setUserRole(em.getReference(UserRole.class, idRole));
			newUser.setUsername(username);
			newUser.setPassword(MyUtils.hash_password_SHA256(password, email));
			newUser.setPhone(phone);
			newUser.setEmail(email);
			newUser.setRegisterTime(MyUtils.getCurrentTime());
			if (avatar != null)
				newUser.setAvatar(avatar);
	    	if (active != null)
	    		newUser.setActive(active);
	    	else
	    		newUser.setActive(true);
			
			em.getTransaction().begin();
	    	em.persist(newUser);
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
	public boolean updateUser(Integer idUser, Integer idRole, String username, String password, String phone, String email, String avatar, Boolean active) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		try {
			User user = em.find(User.class, idUser);
			if (user != null) {
				if (idRole != null)
					user.setUserRole(em.getReference(UserRole.class, idRole));
				if (username != null)
					user.setUsername(username);
				if (password != null) {
					if (email != null) {
						user.setPassword(MyUtils.hash_password_SHA256(password, email));
					}
					else {
						user.setPassword(MyUtils.hash_password_SHA256(password, user.getEmail()));
					}
				}
				if (phone != null)
					user.setPhone(phone);
				
				if (email != null)
				{
					user.setEmail(email);
					if (password != null) {
						user.setPassword(MyUtils.hash_password_SHA256(password, email));
					}
				}
				if (avatar != null)
					user.setAvatar(avatar);
				if (active != null)
					user.setActive(active);
		    	
				em.getTransaction().begin();
		    	em.merge(user);
			    em.getTransaction().commit();
			    return true;
			}
			else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			em.close();
		}
	}

	@Override
	public boolean checkEmailExists(String email) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<User> rootEntry = cq.from(User.class);
		cq.select(cb.count(rootEntry));
		cq.where(cb.equal(rootEntry.get(User_.email), email));
		
		Long ret = em.createQuery(cq).getSingleResult();
		em.close();
		
		return ret != 0;
	}

	@Override
	public boolean checkPhoneExists(String phone) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<User> rootEntry = cq.from(User.class);
		cq.select(cb.count(rootEntry));
		cq.where(cb.equal(rootEntry.get(User_.phone), phone));
		
		Long ret = em.createQuery(cq).getSingleResult();
		em.close();
		
		return ret != 0;
	}
}
