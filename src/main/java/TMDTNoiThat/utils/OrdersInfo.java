package TMDTNoiThat.utils;

import java.util.List;

public class OrdersInfo {
	private List<Integer> idOrders;
	private String amount;
	
	public OrdersInfo() {
	}
	public OrdersInfo(List<Integer> idOrders, String amount) {
		this.idOrders = idOrders;
		this.amount = amount;
	}
	public List<Integer> getIdOrders() {
		return idOrders;
	}
	public void setIdOrders(List<Integer> idOrders) {
		this.idOrders = idOrders;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
}
