package TMDTNoiThat.entity;

import java.io.Serializable;
import javax.persistence.*;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name="Products")
@NamedQuery(name="Product.findAll", query="SELECT p FROM Product p")
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private int active;

	private int availableQuantity;

	private Timestamp createTime;

	private String description;

	private String name;

	private int nsold;

	private int nvisit;

	private BigDecimal price;

	@OneToMany(mappedBy="product")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<Comment> comments;

	@OneToMany(mappedBy="product")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<ProductImage> productImages;

	@ManyToOne
	@JoinColumn(name="idCategory")
	private Category category;

	@ManyToOne
	@JoinColumn(name="idUser")
	private User user;

	public Product() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getActive() {
		return this.active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public int getAvailableQuantity() {
		return this.availableQuantity;
	}

	public void setAvailableQuantity(int availableQuantity) {
		this.availableQuantity = availableQuantity;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getNsold() {
		return this.nsold;
	}

	public void setNsold(int nsold) {
		this.nsold = nsold;
	}

	public int getNvisit() {
		return this.nvisit;
	}

	public void setNvisit(int nvisit) {
		this.nvisit = nvisit;
	}

	public BigDecimal getUnitPrice() {
		return this.price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public List<Comment> getComments() {
		return this.comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<ProductImage> getProductImages() {
		return this.productImages;
	}

	public void setProductImages(List<ProductImage> productImages) {
		this.productImages = productImages;
	}

	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}