package model;

import java.sql.*;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class BBSDAO {
	
	//게시글 삭제
	public void delete(int bbs_num){
		try{
			String sql="delete from bbs where bbs_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);			
			ps.setInt(1, bbs_num);
			ps.execute();
		}catch(Exception e){
			System.out.println("에러:" +e.toString());
		}
	}
	
	//게시글 수정
	public void update(BBSVO vo){
		try{
			String sql="update bbs set title=?, bbs_type=?, content=?, writer=? where bbs_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getBbs_type());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getWriter());
			ps.setInt(5, vo.getBbs_num());
			ps.execute();
		}catch(Exception e){
			System.out.println("에러:" +e.toString());
		}
	}
	
	//게시글 등록
	public void insert(BBSVO vo){
		try{
			String sql="insert into bbs(title, bbs_type, content, writer) values(?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getBbs_type());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getWriter());
			ps.execute();
		}catch(Exception e){
			System.out.println("에러:" +e.toString());
		}
	}
		
	//게시글 읽기
	public BBSVO read(int bbs_num){
		BBSVO vo=new BBSVO();
		try{
			String sql="select * from bbs where bbs_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, bbs_num);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				vo.setBbs_num(rs.getInt("bbs_num"));
				vo.setBbs_type(rs.getString("bbs_type"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setWriter(rs.getString("writer"));
				vo.setWdate(rs.getString("wdate"));
				System.out.println(vo.toString());
			}
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}		
		return vo;
	}
	//게시판 목록
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
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			while(rs.next()){
				JSONObject obj=new JSONObject();
				obj.put("bbs_num", rs.getInt("bbs_num"));
				obj.put("bbs_type", rs.getString("bbs_type"));
				obj.put("title", rs.getString("title"));
				obj.put("content", rs.getString("content"));
				obj.put("writer", rs.getString("writer"));
				obj.put("wdate", sdf.format(rs.getTimestamp("wdate")));
				array.add(obj);
			}
			jObject.put("array", array);
			
			cs.getMoreResults(); //다음 ResultSet으로 이동
			rs=cs.getResultSet();
			int count=0;
			if(rs.next()){
				count=rs.getInt("cnt");
			}
			jObject.put("count", count);
			
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}		
		return jObject;		
	}

}
