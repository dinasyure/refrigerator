package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	public static Connection con;
	static {
      try {
         Class.forName("com.mysql.jdbc.Driver");
         con=DriverManager.getConnection("jdbc:mysql://localhost:3306/refrigerator","refrigerator","pass");
         System.out.println("접속성공");
      }catch(Exception e) {
         System.out.println("에러:" + e.toString());
      }
   }
}