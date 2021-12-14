package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.PaymentMethodDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.PaymentMethod;

public class PaymentMethodDaoImp implements PaymentMethodDao {

	@Override
	public List<PaymentMethod> getAllPaymentMethod() {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<PaymentMethod> cq = cb.createQuery(PaymentMethod.class);
		Root<PaymentMethod> rootEntry = cq.from(PaymentMethod.class);
		CriteriaQuery<PaymentMethod> all = cq.select(rootEntry);

		List<PaymentMethod> ret = em.createQuery(all).getResultList();
		em.close();

		return ret;
	}

}
