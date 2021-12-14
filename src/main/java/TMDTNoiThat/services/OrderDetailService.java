package TMDTNoiThat.services;

import java.util.List;

import TMDTNoiThat.entity.OrderDetail;

public interface OrderDetailService {
	List<OrderDetail> getOrderDetails(Integer idOrder);
}
