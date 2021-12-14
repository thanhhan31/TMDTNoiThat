package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.OrderDetailDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.OrderDetail;
import TMDTNoiThat.entity.OrderDetail_;
import TMDTNoiThat.entity.Order_;

public class OrderDetailDaoImpl implements OrderDetailDao {

	@Override
	public List<OrderDetail> getOrderDetails(Integer idOrder) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<OrderDetail> cq = cb.createQuery(OrderDetail.class);
		Root<OrderDetail> rootEntry = cq.from(OrderDetail.class);
		cq.select(rootEntry);
		cq.where(cb.equal(rootEntry.get(OrderDetail_.order).get(Order_.id), idOrder));

		List<OrderDetail> ret = em.createQuery(cq).getResultList();
		em.close();

		return ret;
	}
}
