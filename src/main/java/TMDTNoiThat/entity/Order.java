package TMDTNoiThat.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name="Orders")
@NamedQuery(name="Order.findAll", query="SELECT o FROM Order o")
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private Timestamp createTime;

	private Integer orderKey;

	private Timestamp paidTime;

	private int status;

	private BigDecimal totalPrice;

	@OneToMany(mappedBy="order", fetch=FetchType.EAGER, cascade = {CascadeType.MERGE})
	private List<OrderDetail> orderDetails;

	@ManyToOne
	@JoinColumn(name="idPaymentMethod")
	private PaymentMethod paymentMethod;

	@ManyToOne
	@JoinColumn(name="idShip")
	private ShipInfo shipInfo;

	@ManyToOne
	@JoinColumn(name="idUser")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="idSeller")
	private User seller;

	public Order() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public User getSeller() {
		return this.seller;
	}

	public void setSeller(User seller) {
		this.seller = seller;
	}

	public Integer getOrderKey() {
		return this.orderKey;
	}

	public void setOrderKey(Integer orderKey) {
		this.orderKey = orderKey;
	}

	public Timestamp getPaidTime() {
		return this.paidTime;
	}

	public void setPaidTime(Timestamp paidTime) {
		this.paidTime = paidTime;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public BigDecimal getTotalPrice() {
		return this.totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public List<OrderDetail> getOrderDetails() {
		return this.orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public PaymentMethod getPaymentMethod() {
		return this.paymentMethod;
	}

	public void setPaymentMethod(PaymentMethod paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public ShipInfo getShipInfo() {
		return this.shipInfo;
	}

	public void setShipInfo(ShipInfo shipInfo) {
		this.shipInfo = shipInfo;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}