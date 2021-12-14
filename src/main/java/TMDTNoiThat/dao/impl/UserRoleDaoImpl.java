package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.UserRoleDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.UserRole;
import TMDTNoiThat.entity.UserRole_;

public class UserRoleDaoImpl implements UserRoleDao {

	@Override
	public List<UserRole> getAllUserRoles() {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<UserRole> cq = cb.createQuery(UserRole.class);
		Root<UserRole> rootEntry = cq.from(UserRole.class);
		CriteriaQuery<UserRole> all = cq.select(rootEntry);

		List<UserRole> ret = em.createQuery(all).getResultList();
		em.close();

		return ret;
	}

	@Override
	public UserRole getUserRoleById(Integer idRole) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<UserRole> cq = cb.createQuery(UserRole.class);
		Root<UserRole> rootEntry = cq.from(UserRole.class);
		CriteriaQuery<UserRole> c = cq.select(rootEntry);
		c.where(cb.equal(rootEntry.get(UserRole_.id), idRole));

		try {
			UserRole ret = em.createQuery(c).getSingleResult();
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}
}
