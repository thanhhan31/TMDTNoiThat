package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.OrderDetail;

public interface OrderDetailDao {
	List<OrderDetail> getOrderDetails(Integer idOrder);
}
