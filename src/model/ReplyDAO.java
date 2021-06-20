package model;

import java.sql.*;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ReplyDAO {
	
	//특정 게시글 댓글 삭제
		public void bbsDel(int bbs_id){
			try{
				String sql="delete from reply where bbs_id=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setInt(1, bbs_id);			
				ps.execute();
			}catch(Exception e){
				System.out.println("에러:" + e.toString());
			}
		}
	
	//댓글 삭제
	public void delete(int reply_num){
		try{
			String sql="delete from reply where reply_num=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, reply_num);			
			ps.execute();
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
	}
	
	//댓글 등록
	public void insert(ReplyVO vo){
		try{
			String sql="insert into reply(bbs_id, reply_content, reply_writer) values(?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, vo.getBbs_id());
			ps.setString(2, vo.getReply_content());
			ps.setString(3, vo.getReply_writer());
			ps.execute();
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
	}
	
	//댓글 목록
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
				obj.put("reply_num", rs.getInt("reply_num"));
				obj.put("bbs_id", rs.getInt("bbs_id"));
				obj.put("reply_content", rs.getString("reply_content"));
				obj.put("reply_writer", rs.getString("reply_writer"));
				obj.put("rdate", sdf.format(rs.getTimestamp("rdate")));
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
