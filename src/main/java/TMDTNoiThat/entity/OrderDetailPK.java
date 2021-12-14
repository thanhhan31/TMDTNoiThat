package TMDTNoiThat.entity;

import java.io.Serializable;

public class OrderDetailPK implements Serializable {
	private static final long serialVersionUID = 1L;

	private int order;

	private int product;

	public OrderDetailPK() {
	}
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public int getProduct() {
		return product;
	}
	public void setProduct(int product) {
		this.product = product;
	}
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof OrderDetailPK)) {
			return false;
		}
		OrderDetailPK castOther = (OrderDetailPK)other;
		return 
			(this.order == castOther.order)
			&& (this.product == castOther.product);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.order;
		hash = hash * prime + this.product;
		
		return hash;
	}
}