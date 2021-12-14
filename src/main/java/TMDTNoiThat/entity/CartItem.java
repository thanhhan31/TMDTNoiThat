package TMDTNoiThat.entity;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name="CartItems")
@IdClass(CartItemPK.class)
public class CartItem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@ManyToOne
	@JoinColumn(name="idProduct")
	private Product product;

	@Id
	@ManyToOne
	@JoinColumn(name="idUser")
	private User user;
	
	private int quantity;

	public CartItem() {
	}

	public int getQuantity() {
		return this.quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}