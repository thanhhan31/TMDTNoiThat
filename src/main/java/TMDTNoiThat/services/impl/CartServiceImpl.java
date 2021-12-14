package TMDTNoiThat.services.impl;

import java.math.BigDecimal;
import java.util.List;

import TMDTNoiThat.dao.CartDao;
import TMDTNoiThat.dao.impl.CartDaoImpl;
import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.services.CartService;

public class CartServiceImpl implements CartService {
	CartDao c = new CartDaoImpl();

	@Override
	public BigDecimal getTotalCartPrice(Integer idUser) {
		return c.getTotalCartPrice(idUser);
	}

	@Override
	public Integer getTotalCartQuantity(Integer idUser) {
		return c.getTotalCartQuantity(idUser);
	}

	@Override
	public List<CartItem> getUserCart(Integer idUser) {
		return c.getUserCart(idUser);
	}

	@Override
	public boolean adjustProductCartQuantity(Integer idUser, Integer idProduct, int new_quantity) {
		return c.adjustProductCartQuantity(idUser, idProduct, new_quantity);
	}

	@Override
	public boolean addProductCart(Integer idUser, Integer idProduct, int quantity) {
		return c.addProductCart(idUser, idProduct, quantity);
	}

	@Override
	public boolean removeProductCart(Integer idUser, Integer idProduct) {
		return c.removeProductCart(idUser, idProduct);
	}
}
