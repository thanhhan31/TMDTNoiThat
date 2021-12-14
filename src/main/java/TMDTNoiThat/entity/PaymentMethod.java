package TMDTNoiThat.entity;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name="PaymentMethods")
@NamedQuery(name="PaymentMethod.findAll", query="SELECT p FROM PaymentMethod p")
public class PaymentMethod implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String name;

	public PaymentMethod() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
}