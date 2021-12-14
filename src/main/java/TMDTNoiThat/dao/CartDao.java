package TMDTNoiThat.dao;

import java.math.BigDecimal;
import java.util.List;

import TMDTNoiThat.entity.CartItem;

public interface CartDao {
	BigDecimal getTotalCartPrice(Integer idUser);
	Integer getTotalCartQuantity(Integer idUser);
	List<CartItem> getUserCart(Integer idUser);

	boolean adjustProductCartQuantity(Integer idUser, Integer idProduct, int new_quantity);
	boolean addProductCart(Integer idUser, Integer idProduct, int quantity);
	boolean removeProductCart(Integer idUser, Integer idProduct);
}
