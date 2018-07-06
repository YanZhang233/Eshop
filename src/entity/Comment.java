package entity;

import java.util.Date;

public class Comment {
	private String username;
	private int itemsId;
	private String message;
	private Date date;

	public Comment() {
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getItemsId() {
		return itemsId;
	}

	public void setItemsId(int itemsId) {
		this.itemsId = itemsId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
