package entity;

public class Cart {
	private int userId;
	private int itemsId;
	private int count;
	private float totalPrice;

	public Cart() {
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getItemsId() {
		return itemsId;
	}

	public void setItemsId(int itemsId) {
		this.itemsId = itemsId;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public float getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}

}
