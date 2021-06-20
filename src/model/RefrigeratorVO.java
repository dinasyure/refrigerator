package model;

public class RefrigeratorVO extends IngVO{
	private int refrigerator_num;
	private String refrigerator_userid;
	private int refrigerator_ingNum;
	private String refrigerator_place;
	private String refrigerator_date;
	private String refrigerator_exDate;
	private String refrigerator_memo;	
	
	
	public int getRefrigerator_num() {
		return refrigerator_num;
	}




	public void setRefrigerator_num(int refrigerator_num) {
		this.refrigerator_num = refrigerator_num;
	}




	public String getRefrigerator_userid() {
		return refrigerator_userid;
	}




	public void setRefrigerator_userid(String refrigerator_userid) {
		this.refrigerator_userid = refrigerator_userid;
	}




	public int getRefrigerator_ingNum() {
		return refrigerator_ingNum;
	}




	public void setRefrigerator_ingNum(int refrigerator_ingNum) {
		this.refrigerator_ingNum = refrigerator_ingNum;
	}




	public String getRefrigerator_place() {
		return refrigerator_place;
	}




	public void setRefrigerator_place(String refrigerator_place) {
		this.refrigerator_place = refrigerator_place;
	}




	public String getRefrigerator_date() {
		return refrigerator_date;
	}




	public void setRefrigerator_date(String refrigerator_date) {
		this.refrigerator_date = refrigerator_date;
	}




	public String getRefrigerator_exDate() {
		return refrigerator_exDate;
	}




	public void setRefrigerator_exDate(String refrigerator_exDate) {
		this.refrigerator_exDate = refrigerator_exDate;
	}




	public String getRefrigerator_memo() {
		return refrigerator_memo;
	}




	public void setRefrigerator_memo(String refrigerator_memo) {
		this.refrigerator_memo = refrigerator_memo;
	}




	@Override
	public String toString() {
		return "RefrigeratorVO [refrigerator_num=" + refrigerator_num + ", refrigerator_userid=" + refrigerator_userid
				+ ", refrigerator_ingNum=" + refrigerator_ingNum + ", refrigerator_place=" + refrigerator_place
				+ ", refrigerator_date=" + refrigerator_date + ", refrigerator_exDate=" + refrigerator_exDate
				+ ", refrigerator_memo=" + refrigerator_memo + ", getIngredient_name()=" + getIngredient_name() + "]";
	}	
}
