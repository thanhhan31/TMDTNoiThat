package TMDTNoiThat.entity;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name="ShipInfos")
@NamedQuery(name="ShipInfo.findAll", query="SELECT s FROM ShipInfo s")
public class ShipInfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String address;

	@ManyToOne
	@JoinColumn(name="idUser")
	private User user;

	public ShipInfo() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}