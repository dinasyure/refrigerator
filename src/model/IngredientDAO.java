package model;

import org.json.simple.*;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class IngredientDAO {
	//냉장고 재료 삭제
	public void delete(int refrigerator_num){		
		try{
			String sql="delete from refrigerator where refrigerator_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);			
			ps.setInt(1, refrigerator_num);			
			ps.execute();			
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}		
	}
	
	//냉장고 재료 정보
	public RefrigeratorVO refRead(int refrigerator_num){
		RefrigeratorVO vo=new RefrigeratorVO();
		try{
			String sql="select * from ref_ing where refrigerator_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, refrigerator_num);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				vo.setRefrigerator_num(rs.getInt("refrigerator_num"));
				vo.setRefrigerator_userid(rs.getString("refrigerator_userid"));
				vo.setRefrigerator_ingNum(rs.getInt("refrigerator_ingNum"));
				vo.setRefrigerator_place(rs.getString("refrigerator_place"));
				vo.setRefrigerator_date(rs.getString("refrigerator_date"));
				vo.setRefrigerator_exDate(rs.getString("refrigerator_exDate"));
				vo.setRefrigerator_memo(rs.getString("refrigerator_memo"));
				vo.setIngredient_name(rs.getString("ingredient_name"));
				System.out.println(vo.toString());
			}
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
		return vo;
	}
	
	//냉장고 재료 수정
	public void update(RefrigeratorVO vo){		
		try{
			String sql="update refrigerator set refrigerator_ingNum=?, refrigerator_place=?, refrigerator_date=?, refrigerator_exDate=?, refrigerator_memo=? where refrigerator_userid=? and refrigerator_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);			
			ps.setInt(1, vo.getRefrigerator_ingNum());
			ps.setString(2, vo.getRefrigerator_place());
			ps.setString(3, vo.getRefrigerator_date());
			ps.setString(4, vo.getRefrigerator_exDate());
			ps.setString(5, vo.getRefrigerator_memo());
			ps.setString(6, vo.getRefrigerator_userid());
			ps.setInt(7, vo.getRefrigerator_num());
			ps.execute();			
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
		
	}
	
	//냉장고 재료 등록
	public void insert(RefrigeratorVO vo){		
		try{
			String sql="insert into refrigerator(refrigerator_userid, refrigerator_ingNum, refrigerator_place, refrigerator_exDate, refrigerator_memo) values(?,?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getRefrigerator_userid());
			ps.setInt(2, vo.getRefrigerator_ingNum());
			ps.setString(3, vo.getRefrigerator_place());
			ps.setString(4, vo.getRefrigerator_exDate());
			ps.setString(5, vo.getRefrigerator_memo());
			ps.execute();			
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
		
	}
	
	//재료 정보
	public IngVO read(String ingredient_num){
		IngVO vo=new IngVO();
		try{
			String sql="select * from ingredient where ingredient_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, ingredient_num);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				vo.setIngredient_num(rs.getInt("ingredient_num"));
				vo.setIngredient_name(rs.getString("ingredient_name"));
				vo.setIngredient_type(rs.getString("ingredient_type"));
				vo.setIngredient_image(rs.getString("ingredient_image"));
			}
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
		return vo;
	}
	//특정 id 냉장고 재료 목록 
	public JSONArray refList(String id){
		JSONArray array = new JSONArray();
		try{
			String sql="select * from ref_ing where refrigerator_userid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			while(rs.next()){
				JSONObject obj=new JSONObject();
				obj.put("refrigerator_num", rs.getInt("refrigerator_num"));
				obj.put("ingredient_name", rs.getString("ingredient_name"));				
				obj.put("refrigerator_userid", rs.getString("refrigerator_userid"));
				obj.put("refrigerator_place", rs.getString("refrigerator_place"));
				obj.put("refrigerator_date", sdf.format(rs.getTimestamp("refrigerator_date")));
				obj.put("refrigerator_exDate", rs.getString("refrigerator_exDate"));
				obj.put("refrigerator_memo", rs.getString("refrigerator_memo"));
				array.add(obj);
			}
		}catch(Exception e){
			System.out.println("에러 :" + e.toString());
		}
		return array;
	}
	//재료목록
	public JSONObject list(SqlVO vo){
		JSONObject jObject=new JSONObject();
		 try{
			 String sql="call list(?,?,?,?,?,?,?)";		 
			 CallableStatement cs=DB.con.prepareCall(sql);
			 cs.setString(1, vo.getTable());
			 cs.setInt(2, vo.getPage());
	         cs.setInt(3, vo.getPerpage());
	         cs.setString(4, vo.getKey());
	         cs.setString(5, vo.getWord());	         
	         cs.setString(6, vo.getOrder());
	         cs.setString(7, vo.getDesc());
	         cs.execute();
	         
	         ResultSet rs=cs.getResultSet();
	         JSONArray array=new JSONArray();	         
	         while(rs.next()){
	        	 JSONObject obj=new JSONObject();
	        	 obj.put("ingredient_num", rs.getInt("ingredient_num"));
	        	 obj.put("ingredient_name", rs.getString("ingredient_name"));
	        	 obj.put("ingredient_type", rs.getString("ingredient_type"));
	        	 obj.put("ingredient_image", rs.getString("ingredient_image"));
	        	 array.add(obj);
	         }
			 jObject.put("array", array);
			 
			 cs.getMoreResults();
	         rs=cs.getResultSet();
	         int count=0;
	         if(rs.next()) count=rs.getInt("cnt");
	         jObject.put("count", count);
		 }catch(Exception e){
			 System.out.println("에러:" + e.toString());
		 }
		return jObject;
	}

}
