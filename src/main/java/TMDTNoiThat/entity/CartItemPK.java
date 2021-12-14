package TMDTNoiThat.entity;

import java.io.Serializable;

public class CartItemPK implements Serializable {
	private static final long serialVersionUID = 1L;

	private int product;
	private int user;

	public CartItemPK() {
	}
	public int getProduct() {
		return product;
	}
	public void setProduct(int product) {
		this.product = product;
	}
	public int getUser() {
		return user;
	}
	public void setUser(int user) {
		this.user = user;
	}
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof CartItemPK)) {
			return false;
		}
		CartItemPK castOther = (CartItemPK)other;
		return 
			(this.user == castOther.user)
			&& (this.product == castOther.product);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.user;
		hash = hash * prime + this.product;
		
		return hash;
	}
}