package entity;

public class Items {
	private int id;
	private String name;
	private String city;
	private float price;
	private String picture;
	private String category;
	private String type;
	private String detail;

	public Items() {
	}

	public Items(int id, String name, String city, float price, String picture) {
		super();
		this.id = id;
		this.name = name;
		this.city = city;
		this.price = price;
		this.picture = picture;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}



	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public int hashCode() {
		
		return this.getId()+this.getName().hashCode();
	}

	public boolean equals(Object obj) {
      if(obj==null)	  return false;

	  if(obj instanceof Items){
		  Items item=(Items)obj;
		  if(item.getName().equals(this.getName())&&item.getId()==(this.getId())){
			  return true;
		  }
		  else return false;
	  }
	  else return false; 

	}

	@Override
	public String toString() {
		return "Items [id=" + id + ", name=" + name + ", city=" + city + ", price=" + price 
				+ ", picture=" + picture + ", category=" + category + ", type=" + type + ", detail=" + detail + "]";
	}


}
