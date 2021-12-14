package TMDTNoiThat.services.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import TMDTNoiThat.dao.OrderDao;
import TMDTNoiThat.dao.impl.OrderDaoImpl;
import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.Order;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.utils.OrdersInfo;

public class OrderServiceImpl implements OrderService {
	OrderDao o = new OrderDaoImpl();
	
	@Override
	public OrdersInfo createOrder(Integer idUser, Integer idShip, List<CartItem> checkoutCarts) {
		return o.createOrder(idUser, idShip, checkoutCarts);
	}

	@Override
	public List<Order> userGetOrders(Integer idUser, Integer status, Integer start, Integer count) {
		return o.userGetOrders(idUser, status, start, count);
	}

	@Override
	public Order getOrderById(Integer idOrder) {
		return o.getOrderById(idOrder);
	}

	@Override
	public boolean cancelOrder(Integer idOrder) {
		return o.canceledOrder(idOrder);
	}

	@Override
	public boolean paidOrder(Integer idOrder, Date paidTime, Integer idPaymentMethod) {
		return o.paidOrder(idOrder, paidTime, idPaymentMethod);
	}

	@Override
	public Map<Integer, List<Integer>> sellerGetYearsOrders(Integer idUser) {
		return o.sellerGetYearsOrders(idUser);
	}

	@Override
	public Map<Integer, BigDecimal> sellerReportIncomeByYear(Integer idUser, Integer year) {
		return o.sellerReportIncomeByYear(idUser, year);
	}

	@Override
	public Map<Integer, BigDecimal> sellerReportIncomeByMonth(Integer idUser, Integer year, Integer month) {
		return o.sellerReportIncomeByMonth(idUser, year, month);
	}

	@Override
	public List<Order> getOrderByKey(Integer orderKey) {
		return o.getOrderByKey(orderKey);
	}

	@Override
	public boolean setOrderKey(Integer idOrder, Integer orderKey) {
		return o.setOrderKey(idOrder, orderKey);
	}

	@Override
	public boolean deliveredOrder(Integer idOrder) {
		return o.deliveredOrder(idOrder);
	}
	
	@Override
	public List<Order> sellerGetOrders(Integer idUser, Integer status, Integer start, Integer count) {
		return o.sellerGetOrders(idUser, status, start, count);
	}

	@Override
	public Long userCountOrders(Integer idUser, Integer status) {
		return o.userCountOrders(idUser, status);
	}

	@Override
	public Long sellerCountOrders(Integer idUser, Integer status) {
		return o.sellerCountOrders(idUser, status);
	}

	@Override
	public Long adminCountOrders(Integer status) {
		return o.userCountOrders(null, status);
	}

	@Override
	public Map<Integer, List<Integer>> adminGetYearsOrders() {
		return o.sellerGetYearsOrders(null);
	}

	@Override
	public Map<Integer, BigDecimal> adminReportIncomeByYear(Integer year) {
		return o.sellerReportIncomeByYear(null, year);
	}

	@Override
	public Map<Integer, BigDecimal> adminReportIncomeByMonth(Integer year, Integer month) {
		return o.sellerReportIncomeByMonth(null, year, month);
	}
}
