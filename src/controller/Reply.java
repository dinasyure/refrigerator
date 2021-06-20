package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

@WebServlet(value={"/reply/list.json", "/reply/insert", "/reply/delete"})
public class Reply extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReplyDAO dao=new ReplyDAO();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      response.setContentType("text/html;charset=UTF-8");
	      String path=request.getServletPath();
	      PrintWriter out=response.getWriter();
	      RequestDispatcher dis;
	      switch(path) {
	      case "/reply/delete":
	    	  dao.delete(Integer.parseInt(request.getParameter("reply_num")));
	    	  break;
	      case "/reply/list.json":
	         SqlVO vo=new SqlVO();
	         vo.setPage(Integer.parseInt(request.getParameter("page")));
	         vo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
	         int bbs_id=Integer.parseInt(request.getParameter("bbs_id"));
	         vo.setTable("(select * from reply where bbs_id=" + bbs_id + ") tbl");
	         vo.setKey("reply_writer");
	         vo.setWord("");
	         vo.setOrder("reply_num");
	         vo.setDesc("desc");
	         System.out.println(vo.toString());
	         out.println(dao.list(vo));
	         break;
	      }
	   }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {request.setCharacterEncoding("UTF-8");
	String path=request.getServletPath();
	
	ReplyVO vo=new ReplyVO();	
	vo.setBbs_id(Integer.parseInt(request.getParameter("bbs_id")));
	vo.setReply_writer(request.getParameter("reply_writer"));
	vo.setReply_content(request.getParameter("reply_content"));
	System.out.println(vo.toString());
	
	switch(path){
	case "/reply/insert":
		dao.insert(vo);
		response.sendRedirect("/bbs/read?bbs_num=" + request.getParameter("bbs_id"));
		break;	
	}	
	
	}

}
