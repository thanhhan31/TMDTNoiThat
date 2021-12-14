package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.ShipInfoDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.ShipInfo;
import TMDTNoiThat.entity.ShipInfo_;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.entity.User_;

public class ShipInfoDaoImpl implements ShipInfoDao {

	@Override
	public List<ShipInfo> getUserShipInfos(Integer idUser) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<ShipInfo> cq = cb.createQuery(ShipInfo.class);
		Root<ShipInfo> rootEntry = cq.from(ShipInfo.class);
		CriteriaQuery<ShipInfo> all = cq.select(rootEntry);
		all.where(cb.equal(rootEntry.get(ShipInfo_.user).get(User_.id), idUser));

		List<ShipInfo> ret = em.createQuery(all).getResultList();
		em.close();

		return ret;
	}
	
	@Override
	public Long countUserShipInfos(Integer idUser) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder qb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = qb.createQuery(Long.class);
		
		Root<ShipInfo> rootEntry = cq.from(ShipInfo.class);
		cq.select(qb.count(rootEntry));
		cq.where(qb.equal(rootEntry.get(ShipInfo_.user).get(User_.id), idUser));

		Long ret = em.createQuery(cq).getSingleResult();
		em.close();
		
		return ret;
	}

	@Override
	public ShipInfo getShipInfosInfoById(Integer idShip) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		ShipInfo ret = em.find(ShipInfo.class, idShip);
		em.close();
		return ret;
	}

	@Override
	public boolean addUserShipInfo(User user, String address) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		try {
			ShipInfo s = new ShipInfo();
	    	s.setUser(user);
	    	s.setAddress(address);
	    	
			em.getTransaction().begin();
	    	em.persist(s);
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
	public boolean updateUserShipInfo(Integer idShip, String address) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		try {
			ShipInfo s = getShipInfosInfoById(idShip);
			if (s != null) {
				s.setAddress(address);
				em.getTransaction().begin();
		    	em.merge(s);
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
	public boolean deleteUserShipInfo(Integer idShip) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaDelete<ShipInfo> d = cb.createCriteriaDelete(ShipInfo.class);
		Root<ShipInfo> rootEntry = d.from(ShipInfo.class);
		d.where(cb.equal(rootEntry.get(ShipInfo_.id), idShip));
		
		try {
			em.getTransaction().begin();
			if (em.createQuery(d).executeUpdate() != 0) {
				ret = true;
			}
			em.getTransaction().commit();
			return ret;
		}
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			em.close();
		}
	}
}
