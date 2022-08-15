package manager.product;

import java.sql.Timestamp;

public class ProductDTO {
	private int product_id;
	private String product_category;
	private String product_name;
	private int product_price;
	private int product_stock;
	private String product_detail;
	private String product_image1;
	private String product_image2;
	private String product_image3;
	private String product_brand;
	private String product_size;
	private String product_color;
	private int discount_rate;
	private Timestamp reg_date;
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_stock() {
		return product_stock;
	}
	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}
	public String getProduct_detail() {
		return product_detail;
	}
	public void setProduct_detail(String product_detail) {
		this.product_detail = product_detail;
	}
	public String getProduct_image1() {
		return product_image1;
	}
	public void setProduct_image1(String product_image1) {
		this.product_image1 = product_image1;
	}
	public String getProduct_image2() {
		return product_image2;
	}
	public void setProduct_image2(String product_image2) {
		this.product_image2 = product_image2;
	}
	public String getProduct_image3() {
		return product_image3;
	}
	public void setProduct_image3(String product_image3) {
		this.product_image3 = product_image3;
	}
	public String getProduct_brand() {
		return product_brand;
	}
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	public String getProduct_size() {
		return product_size;
	}
	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}
	public String getProduct_color() {
		return product_color;
	}
	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}
	public int getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "ProductDTO [product_id=" + product_id + ", product_category=" + product_category + ", product_name="
				+ product_name + ", product_price=" + product_price + ", product_stock=" + product_stock
				+ ", product_detail=" + product_detail + ", product_image1=" + product_image1 + ", product_image2="
				+ product_image2 + ", product_image3=" + product_image3 + ", product_brand=" + product_brand
				+ ", product_size=" + product_size + ", product_color=" + product_color + ", discount_rate="
				+ discount_rate + ", reg_date=" + reg_date + "]";
	}
	


}
