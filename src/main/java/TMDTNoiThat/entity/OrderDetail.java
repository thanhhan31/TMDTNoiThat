package TMDTNoiThat.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="OrderDetails")
@IdClass(OrderDetailPK.class)
public class OrderDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@ManyToOne
	@JoinColumn(name="idOrder")
	private Order order;

	@Id
	@ManyToOne
	@JoinColumn(name="idProduct")
	private Product product;
	
	private int quantity;

	private BigDecimal unitPrice;
	
	public OrderDetail() {
	}

	public OrderDetail(Order order, Product product, int quantity, BigDecimal unitPrice) {
		this.order = order;
		this.product = product;
		this.quantity = quantity;
		this.unitPrice = unitPrice;
	}
	
	public int getQuantity() {
		return this.quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Order getOrder() {
		return this.order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

}