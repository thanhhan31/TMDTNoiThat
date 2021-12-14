package TMDTNoiThat.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.Order;
import TMDTNoiThat.utils.OrdersInfo;

public interface OrderDao {
	OrdersInfo createOrder(Integer idUser, Integer idShip, List<CartItem> checkoutCarts);
	
	List<Order> userGetOrders(Integer idUser, Integer status, Integer start, Integer count);
	Long userCountOrders(Integer idUser, Integer status);
	
	Order getOrderById(Integer idOrder);
	List<Order> getOrderByKey(Integer orderKey);
	
	List<Order> sellerGetOrders(Integer idUser, Integer status, Integer start, Integer count);
	Long sellerCountOrders(Integer idUser, Integer status);
	
	Map<Integer, List<Integer>> sellerGetYearsOrders(Integer idUser);
	Map<Integer, BigDecimal> sellerReportIncomeByYear(Integer idUser, Integer year);
	Map<Integer, BigDecimal> sellerReportIncomeByMonth(Integer idUser, Integer year, Integer month);
	
	boolean canceledOrder(Integer idOrder);
	boolean paidOrder(Integer idOrder, Date paidTime, Integer idPaymentMethod);
	boolean deliveredOrder(Integer idOrder);
	boolean setOrderKey(Integer idOrder, Integer orderKey);
}
