package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.OrderDetailDao;
import TMDTNoiThat.dao.impl.OrderDetailDaoImpl;
import TMDTNoiThat.entity.OrderDetail;
import TMDTNoiThat.services.OrderDetailService;

public class OrderDetailServiceImpl implements OrderDetailService {
	OrderDetailDao odt = new OrderDetailDaoImpl();
	
	@Override
	public List<OrderDetail> getOrderDetails(Integer idOrder) {
		return odt.getOrderDetails(idOrder);
	}
}
