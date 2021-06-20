package model;

public class CartVO extends IngVO{
	
	private int cart_num;
	private String cart_userid;
	private int cart_ingNum;
	private String cart_place;
	private String cart_memo;
	
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public String getCart_userid() {
		return cart_userid;
	}
	public void setCart_userid(String cart_userid) {
		this.cart_userid = cart_userid;
	}
	public int getCart_ingNum() {
		return cart_ingNum;
	}
	public void setCart_ingNum(int cart_ingNum) {
		this.cart_ingNum = cart_ingNum;
	}
	public String getCart_place() {
		return cart_place;
	}
	public void setCart_place(String cart_place) {
		this.cart_place = cart_place;
	}
	public String getCart_memo() {
		return cart_memo;
	}
	public void setCart_memo(String cart_memo) {
		this.cart_memo = cart_memo;
	}
	
	@Override
	public String toString() {
		return "CartVO [cart_num=" + cart_num + ", cart_userid=" + cart_userid + ", cart_ingNum=" + cart_ingNum
				+ ", cart_place=" + cart_place + ", cart_memo=" + cart_memo + ", getIngredient_name()="
				+ getIngredient_name() + "]";
	}	
	
}
