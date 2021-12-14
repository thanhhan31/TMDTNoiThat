package TMDTNoiThat.dao.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.CartDao;
import TMDTNoiThat.dao.OrderDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.OrderDetail;
import TMDTNoiThat.entity.OrderDetail_;
import TMDTNoiThat.entity.Order;
import TMDTNoiThat.entity.Order_;
import TMDTNoiThat.entity.PaymentMethod;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.entity.ShipInfo;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.entity.User_;
import TMDTNoiThat.utils.ConstantValue;
import TMDTNoiThat.utils.MyUtils;
import TMDTNoiThat.utils.OrdersInfo;

public class OrderDaoImpl implements OrderDao {

	@Override
	public OrdersInfo createOrder(Integer idUser, Integer idShip, List<CartItem> checkoutCarts) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		if (checkoutCarts.size() == 0)
			return null;
		
		ShipInfo ship = em.getReference(ShipInfo.class, idShip);
		User user = em.getReference(User.class, idUser);
		
		List<Integer> idOrders = new ArrayList<Integer>();
		List<User> sellers = new ArrayList<User>();
		Map<Integer, BigDecimal> subTotalPrices = new HashMap<Integer, BigDecimal>();
		
		BigDecimal totalPrice = BigDecimal.ZERO;

		for (CartItem c : checkoutCarts) {
			if (!sellers.contains(c.getProduct().getUser())) {
				User seller = c.getProduct().getUser();
				sellers.add(seller);
				
				BigDecimal itemPrice = BigDecimal.ZERO;
				BigDecimal subTotalPrice = BigDecimal.ZERO;
				for (CartItem i : checkoutCarts) {
					if (i.getProduct().getUser().getId() == seller.getId()) {
						itemPrice = i.getProduct().getUnitPrice().multiply(BigDecimal.valueOf(i.getQuantity()));
						subTotalPrice = subTotalPrice.add(itemPrice);
					}
				}
				totalPrice = totalPrice.add(subTotalPrice);
				subTotalPrices.put(seller.getId(), subTotalPrice);
			}
		}
		
		for (User seller : sellers) {		
			List<OrderDetail> odt = new ArrayList<OrderDetail>();
			
			Order order = new Order();
			order.setUser(user);
			order.setSeller(seller);
			order.setCreateTime(MyUtils.getCurrentTime());
			
			em.getTransaction().begin();
			em.persist(order);
			em.flush();

			for (CartItem c : checkoutCarts) {
				if (c.getProduct().getUser().getId() != seller.getId())
					continue;
				
				OrderDetail x = new OrderDetail(
						em.getReference(Order.class, order.getId()),
						em.getReference(Product.class, c.getProduct().getId()),
						c.getQuantity(), 
						c.getProduct().getUnitPrice());
				em.persist(x);
				
				Product p = c.getProduct();
				p.setNsold(p.getNsold() + c.getQuantity());
				p.setAvailableQuantity(p.getAvailableQuantity() - c.getQuantity());
				em.merge(p);
				
				odt.add(x);
			}
			
			order.setTotalPrice(subTotalPrices.get(seller.getId()));
			order.setOrderDetails(odt);
			order.setStatus(ConstantValue.PENDING_ORDER);
			order.setShipInfo(ship);

			em.merge(order);
			em.getTransaction().commit();
			
			idOrders.add(order.getId());
		}
		
		CartDao cartDao = new CartDaoImpl();
		for (CartItem c : checkoutCarts) {
			cartDao.removeProductCart(user.getId(), c.getProduct().getId());
		}
		
		return new OrdersInfo(idOrders, totalPrice.setScale(0, RoundingMode.UP).toString());
	}

	@Override
	public List<Order> userGetOrders(Integer idUser, Integer status, Integer start, Integer count) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Order> cq = cb.createQuery(Order.class);
		Root<Order> rootEntry = cq.from(Order.class);
		cq.select(rootEntry);
		
		if (status != null) {
			cq.where(cb.and(cb.equal(rootEntry.get(Order_.user).get(User_.id), idUser),
					cb.equal(rootEntry.get(Order_.status), status)));
		}
		else {
			cq.where(cb.equal(rootEntry.get(Order_.user).get(User_.id), idUser));
		}
		
		cq.orderBy(cb.desc(rootEntry.get(Order_.createTime)));

		List<Order> ret = 
				em.createQuery(cq)
				.setFirstResult(start)
				.setMaxResults(count)
				.getResultList();
		em.close();

		return ret;
	}
	
	@Override
	public Long userCountOrders(Integer idUser, Integer status) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<Order> rootEntry = cq.from(Order.class);
		
		cq.select(cb.count(rootEntry));
		
		List<Predicate> cond = new ArrayList<Predicate>();
		
		if (status != null) {
			cond.add(cb.equal(rootEntry.get(Order_.status), status));
		}
		
		if (idUser != null) {
			cond.add(cb.equal(rootEntry.get(Order_.user).get(User_.id), idUser));
		}
		
		Predicate finalCond = cb.and(cond.toArray(new Predicate[0]));
		cq.where(finalCond);
		
		Long ret =  em.createQuery(cq).getSingleResult();
		em.close();
		return ret;
	}
	
	@Override
	public List<Order> sellerGetOrders(Integer idUser, Integer status, Integer start, Integer count) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Order> cq = cb.createQuery(Order.class);
		Root<Order> rootEntry = cq.from(Order.class);
		cq.select(rootEntry);
		
		if (status != null)
		{
			cq.where(cb.and(cb.equal(rootEntry.get(Order_.seller).get(User_.id), idUser)),
					cb.equal(rootEntry.get(Order_.status), status));
		}
		else {
			cq.where(cb.equal(rootEntry.get(Order_.seller).get(User_.id), idUser));
		}
		
		cq.orderBy(cb.desc(rootEntry.get(Order_.createTime)));
		
		List<Order> ret = 
				em.createQuery(cq)
				.setFirstResult(start)
				.setMaxResults(count)
				.getResultList();
		em.close();
		
		return ret;
	}
	
	@Override
	public Long sellerCountOrders(Integer idUser, Integer status) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<Order> rootEntry = cq.from(Order.class);
		
		cq.select(cb.count(rootEntry));
		
		if (status != null)
		{
			cq.where(cb.and(cb.equal(rootEntry.get(Order_.seller).get(User_.id), idUser)),
					cb.equal(rootEntry.get(Order_.status), status));
		}
		else {
			cq.where(cb.equal(rootEntry.get(Order_.seller).get(User_.id), idUser));
		}

		Long ret =  em.createQuery(cq).getSingleResult();
		em.close();
		return ret;
	}
	
	@Override
	public Map<Integer, List<Integer>> sellerGetYearsOrders(Integer idUser) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Date> cq = cb.createQuery(Date.class);
		
		Root<Order> rootEntry = cq.from(Order.class);
		cq.select(rootEntry.get(Order_.createTime));
		
		if (idUser != null) {
			cq.where(cb.and(cb.equal(rootEntry.get(Order_.seller).get(User_.id), idUser)),
					cb.greaterThanOrEqualTo(rootEntry.get(Order_.status), ConstantValue.PAID_ORDER));
		}
		else { //for admin report
			cq.where(cb.greaterThanOrEqualTo(rootEntry.get(Order_.status), ConstantValue.PAID_ORDER));
		}
		
		List<Date> t = em.createQuery(cq).getResultList();
		Map<Integer, List<Integer>> timeMap = new LinkedHashMap<Integer, List<Integer>>();
		
		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		
		for (Date x : t) {
			cal.setTime(x);
			int year = cal.get(Calendar.YEAR);
			
			if (!timeMap.containsKey(year)) {
				List<Integer> months = new ArrayList<Integer>();
				for (Date y : t) {
					cal2.setTime(y);	
					if (cal2.get(Calendar.YEAR) == year) {
						if (!months.contains(cal2.get(Calendar.MONTH) + 1)) {
							months.add(cal2.get(Calendar.MONTH) + 1);
						}
					}
				}
				timeMap.put(year, months);
			}
		}
		em.close();
		return timeMap;
	}
	
	@Override
	public Map<Integer, BigDecimal> sellerReportIncomeByYear(Integer idUser, Integer year){
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Tuple> cq = cb.createQuery(Tuple.class);
		Root<OrderDetail> rootEntry = cq.from(OrderDetail.class);
		
		cq.multiselect(cb.function("MONTH", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), 
				cb.sum(cb.prod(rootEntry.get(OrderDetail_.unitPrice), rootEntry.get(OrderDetail_.quantity))));
		
		if (idUser != null) {
			cq.where(cb.and(
					cb.equal(rootEntry.get(OrderDetail_.order).get(Order_.seller).get(User_.id), idUser),
					cb.greaterThanOrEqualTo(rootEntry.get(OrderDetail_.order).get(Order_.status), ConstantValue.PAID_ORDER),
					cb.equal(cb.function("YEAR", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), year)));
		}
		else { //for admin report
			cq.where(cb.and(
					cb.greaterThanOrEqualTo(rootEntry.get(OrderDetail_.order).get(Order_.status), ConstantValue.PAID_ORDER),
					cb.equal(cb.function("YEAR", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), year)));
		}
		
		
		cq.groupBy(cb.function("MONTH", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)));
		cq.orderBy(cb.asc(cb.function("MONTH", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime))));

		List<Tuple> lt = em.createQuery(cq).getResultList();
		em.close();
		
		Map<Integer, BigDecimal> ret = new LinkedHashMap<Integer, BigDecimal>();
		
		boolean found;
		for (int i = 1; i <= 12; i++) {
			found = false;
			for (Tuple t : lt) {
				if ((Integer)t.get(0) == i) {
					ret.put(i, (BigDecimal)t.get(1));
					found = true;
					break;
				}
			}
			if (!found) {
				ret.put(i, BigDecimal.ZERO);
			}
		}
		
		return ret;
	}
	
	@Override
	public Map<Integer, BigDecimal> sellerReportIncomeByMonth(Integer idUser, Integer year, Integer month){
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Tuple> cq = cb.createQuery(Tuple.class);
		Root<OrderDetail> rootEntry = cq.from(OrderDetail.class);
		
		cq.multiselect(cb.function("DAY", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), 
				cb.sum(cb.prod(rootEntry.get(OrderDetail_.unitPrice), rootEntry.get(OrderDetail_.quantity))));
		
		if (idUser != null) {
			cq.where(cb.and(
					cb.equal(rootEntry.get(OrderDetail_.order).get(Order_.seller).get(User_.id), idUser),
					cb.greaterThanOrEqualTo(rootEntry.get(OrderDetail_.order).get(Order_.status), ConstantValue.PAID_ORDER),
					cb.equal(cb.function("YEAR", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), year),
					cb.equal(cb.function("MONTH", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), month)));
		}
		else {
			cq.where(cb.and(
					cb.greaterThanOrEqualTo(rootEntry.get(OrderDetail_.order).get(Order_.status), ConstantValue.PAID_ORDER),
					cb.equal(cb.function("YEAR", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), year),
					cb.equal(cb.function("MONTH", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)), month)));
		}
		
		cq.groupBy(cb.function("DAY", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime)));
		cq.orderBy(cb.asc(cb.function("DAY", Integer.class, rootEntry.get(OrderDetail_.order).get(Order_.createTime))));

		List<Tuple> lt = em.createQuery(cq).getResultList();
		em.close();
		
		Map<Integer, BigDecimal> ret = new LinkedHashMap<Integer, BigDecimal>();
		YearMonth ym = YearMonth.of(year, month);
		
		boolean found;
		for (int i = 1; i <= ym.lengthOfMonth(); i++) {
			found = false;
			for (Tuple t : lt) {
				if ((Integer)t.get(0) == i) {
					ret.put(i, (BigDecimal)t.get(1));
					found = true;
					break;
				}
			}
			if (!found) {
				ret.put(i, BigDecimal.ZERO);
			}
		}
		
		return ret;
	}

	@Override
	public Order getOrderById(Integer idOrder) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Order> cq = cb.createQuery(Order.class);
		Root<Order> rootEntry = cq.from(Order.class);
		cq.select(rootEntry).where(cb.equal(rootEntry.get(Order_.id), idOrder));

		try {
			return em.createQuery(cq).getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}
	
	@Override
	public List<Order> getOrderByKey(Integer orderKey) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Order> cq = cb.createQuery(Order.class);
		Root<Order> rootEntry = cq.from(Order.class);
		cq.select(rootEntry).where(cb.equal(rootEntry.get(Order_.orderKey), orderKey));

		try {
			List<Order> ret = em.createQuery(cq).getResultList();
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			em.close();
		}
	}

	@Override
	public boolean canceledOrder(Integer idOrder) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		try {
			Order order = em.getReference(Order.class, idOrder);
			order.setStatus(ConstantValue.CANCELED_ORDER);
			em.getTransaction().begin();
			em.merge(order);
			List<OrderDetail> odts = order.getOrderDetails();
			for (OrderDetail odt : odts) {
				Product p = odt.getProduct();
				p.setNsold(p.getNsold() - odt.getQuantity());
				p.setAvailableQuantity(p.getAvailableQuantity() + odt.getQuantity());
				em.merge(p);
			}
			em.getTransaction().commit();
			ret = true;
		}
		catch (Exception e) {
			e.printStackTrace();
			ret = false;
		}
		
		em.close();
		return ret;
	}

	@Override
	public boolean paidOrder(Integer idOrder, Date paidTime, Integer idPaymentMethod) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		try {
			Order order = em.getReference(Order.class, idOrder);
			order.setStatus(ConstantValue.PAID_ORDER);
			order.setPaymentMethod(em.getReference(PaymentMethod.class, idPaymentMethod));
			em.getTransaction().begin();
			em.merge(order);
			em.getTransaction().commit();
			ret = true;
		}
		catch (Exception e) {
			e.printStackTrace();
			ret = false;
		}
		
		em.close();
		return ret;
	}
	
	@Override
	public boolean deliveredOrder(Integer idOrder) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		try {
			Order order = em.getReference(Order.class, idOrder);
			order.setStatus(ConstantValue.DELIVERED_ORDER);
			em.getTransaction().begin();
			em.merge(order);
			em.getTransaction().commit();
			ret = true;
		}
		catch (Exception e) {
			e.printStackTrace();
			ret = false;
		}
		
		em.close();
		return ret;
	}
	

	@Override
	public boolean setOrderKey(Integer idOrder, Integer orderKey) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		try {
			Order order = em.getReference(Order.class, idOrder);
			order.setOrderKey(orderKey);
			em.getTransaction().begin();
			em.merge(order);
			em.getTransaction().commit();
			ret = true;
		}
		catch (Exception e) {
			e.printStackTrace();
			ret = false;
		}
		
		em.close();
		return ret;
	}
}
