package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class CartDAO {
	
	//��ٱ��� ��� ����
	public void delete(int cart_num){
		try{
			String sql="delete from cart where cart_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);			
			ps.setInt(1, cart_num);			
			ps.execute();
		}catch(Exception e){
			System.out.println("����:" + e.toString());
		}
	}
	//��ٱ��� ��� ���
	public void insert(CartVO vo){
		try{
			String sql="insert into cart(cart_userid, cart_ingNum, cart_place, cart_memo) values(?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getCart_userid());
			ps.setInt(2, vo.getCart_ingNum());
			ps.setString(3, vo.getCart_place());
			ps.setString(4, vo.getCart_memo());
			ps.execute();
		}catch(Exception e){
			System.out.println("����:" + e.toString());
		}
	}
	//Ư�� id ��ٱ��� ��� ��� 
		public JSONArray List(String id){
			JSONArray array = new JSONArray();
			try{
				String sql="select * from cart_ing where cart_userid=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setString(1, id);
				ResultSet rs=ps.executeQuery();				
				while(rs.next()){
					JSONObject obj=new JSONObject();
					obj.put("cart_num", rs.getInt("cart_num"));
					obj.put("cart_ingNum", rs.getInt("cart_ingNum"));
					obj.put("ingredient_name", rs.getString("ingredient_name"));				
					obj.put("cart_userid", rs.getString("cart_userid"));
					obj.put("cart_place", rs.getString("cart_place"));					
					obj.put("cart_memo", rs.getString("cart_memo"));
					array.add(obj);
				}
			}catch(Exception e){
				System.out.println("���� :" + e.toString());
			}
			return array;
		}
}
