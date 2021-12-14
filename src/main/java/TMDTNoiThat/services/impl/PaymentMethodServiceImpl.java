package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.PaymentMethodDao;
import TMDTNoiThat.dao.impl.PaymentMethodDaoImp;
import TMDTNoiThat.entity.PaymentMethod;
import TMDTNoiThat.services.PaymentMethodService;

public class PaymentMethodServiceImpl implements PaymentMethodService {
	PaymentMethodDao p = new PaymentMethodDaoImp();
	@Override
	public List<PaymentMethod> getAllPaymentMethod() {
		return p.getAllPaymentMethod();
	}

}
