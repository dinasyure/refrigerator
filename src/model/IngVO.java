package model;

public class IngVO {
	private int ingredient_num;
	private String ingredient_name;
	private String ingredient_type;
	private String ingredient_image;
	
	public int getIngredient_num() {
		return ingredient_num;
	}
	public void setIngredient_num(int ingredient_num) {
		this.ingredient_num = ingredient_num;
	}
	public String getIngredient_name() {
		return ingredient_name;
	}
	public void setIngredient_name(String ingredient_name) {
		this.ingredient_name = ingredient_name;
	}
	public String getIngredient_type() {
		return ingredient_type;
	}
	public void setIngredient_type(String ingredient_type) {
		this.ingredient_type = ingredient_type;
	}
	public String getIngredient_image() {
		return ingredient_image;
	}
	public void setIngredient_image(String ingredient_image) {
		this.ingredient_image = ingredient_image;
	}
	@Override
	public String toString() {
		return "IngVO [ingredient_num=" + ingredient_num + ", ingredient_name=" + ingredient_name + ", ingredient_type="
				+ ingredient_type + ", ingredient_image=" + ingredient_image + "]";
	}	
	
}
