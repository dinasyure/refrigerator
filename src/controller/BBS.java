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

@WebServlet(value={"/bbs/list", "/bbs/list.json","/bbs/read","/bbs/insert","/bbs/update","/bbs/delete"})
public class BBS extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BBSDAO dao=new BBSDAO();
	ReplyDAO rdao=new ReplyDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String path=request.getServletPath();
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=null;
		
		switch(path){
		case "/bbs/delete":
			int bbs_num=Integer.parseInt(request.getParameter("bbs_num"));
			rdao.bbsDel(bbs_num);
			dao.delete(bbs_num);
			response.sendRedirect("/bbs/list");
			break;
		case "/bbs/update":
			bbs_num=Integer.parseInt(request.getParameter("bbs_num"));			
			request.setAttribute("vo", dao.read(bbs_num));
			request.setAttribute("pageName", "/bbs/update.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/insert":						
			request.setAttribute("pageName", "/bbs/insert.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/read":
			bbs_num=Integer.parseInt(request.getParameter("bbs_num"));			
			request.setAttribute("vo", dao.read(bbs_num));
			request.setAttribute("pageName", "/bbs/read.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/list":			
			request.setAttribute("pageName", "/bbs/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/list.json":
			SqlVO vo=new SqlVO();
			vo.setTable("bbs");
			vo.setPage(Integer.parseInt(request.getParameter("page")));
			vo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
			vo.setKey(request.getParameter("key"));
			vo.setWord(request.getParameter("word"));
			vo.setOrder(request.getParameter("order"));
			vo.setDesc(request.getParameter("desc"));			
			
			out.println(dao.list(vo));
			break;
		}
	}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();		
		
		switch(path){
		case "/bbs/insert":
			BBSVO vo=new BBSVO();			
			vo.setTitle(request.getParameter("title"));
			vo.setBbs_type(request.getParameter("bbs_type"));
			vo.setWriter(request.getParameter("writer"));
			vo.setContent(request.getParameter("content"));
			System.out.println(vo.toString());
			dao.insert(vo);			
			break;
		case "/bbs/update":
			vo=new BBSVO();
			vo.setBbs_num(Integer.parseInt(request.getParameter("bbs_num")));
			vo.setTitle(request.getParameter("title"));
			vo.setBbs_type(request.getParameter("bbs_type"));
			vo.setWriter(request.getParameter("writer"));
			vo.setContent(request.getParameter("content"));
			System.out.println(vo.toString());
			dao.update(vo);
			break;
		}
		response.sendRedirect("/bbs/list");
	}
}
