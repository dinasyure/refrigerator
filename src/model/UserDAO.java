package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	//사용자 정보 읽기
	public UserVO read(String uid){
		UserVO vo=new UserVO();
		try{
			String sql="select * from userinfo where uid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));				
			}
		}catch(Exception e){
			System.out.println("에러:" + e.toString());
		}
		return vo;
	}
}
