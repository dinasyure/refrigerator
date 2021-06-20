package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

@WebServlet(value={"/home","/refrigerator/list","/ing/list.json", "/refrigerator/list.json", "/refrigerator/insert", "/refrigerator/read", "/refrigerator/update", "/refrigerator/delete", "/search", "/myinfo","/bbslist.json"})
public class Ingredient extends HttpServlet {
	private static final long serialVersionUID = 1L;
	IngredientDAO dao=new IngredientDAO();
	BBSDAO bbsdao=new BBSDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");		
		PrintWriter out=response.getWriter();
		String path=request.getServletPath();
		RequestDispatcher dis=null;
		switch(path){
		case "/bbslist.json":
			SqlVO vo=new SqlVO();
			vo.setTable("bbs");
			vo.setPage(Integer.parseInt(request.getParameter("page")));
			vo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
			vo.setKey("writer");
			HttpSession session=request.getSession();
			UserVO userVO=(UserVO)session.getAttribute("user");
			String id=userVO==null ? "" : userVO.getUid();
			System.out.println("id..............." + id);
			vo.setWord(id);
			vo.setOrder(request.getParameter("order"));
			vo.setDesc(request.getParameter("desc"));			
			
			out.println(bbsdao.list(vo));
			break;
		case "/myinfo":
			request.setAttribute("pageName", "myinfo.jsp");
			dis=request.getRequestDispatcher("home.jsp");
			dis.forward(request, response);
			break;
		case "/refrigerator/delete":
			dao.delete(Integer.parseInt(request.getParameter("refrigerator_num")));
			response.sendRedirect("list");
			break;
		case "/refrigerator/read":
			request.setAttribute("vo", dao.refRead(Integer.parseInt(request.getParameter("refrigerator_num"))));
			request.setAttribute("pageName", "/refrigerator/read.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/search":
			request.setAttribute("pageName", "search.jsp");
			dis=request.getRequestDispatcher("home.jsp");
			dis.forward(request, response);
			break;
		case "/refrigerator/insert":
			request.setAttribute("vo", dao.read(request.getParameter("ingredient_num")));			
			request.setAttribute("pageName", "/refrigerator/insert.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/refrigerator/list.json":
			 session=request.getSession();
			 userVO=(UserVO)session.getAttribute("user");
			 id=userVO==null ? "" : userVO.getUid();
			System.out.println("id..............." + id);
			out.println(dao.refList(id));
			break;
		case "/refrigerator/list":
			request.setAttribute("pageName", "/refrigerator/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/ing/list.json":
			SqlVO svo=new SqlVO();
			svo.setTable("ingredient");
			svo.setKey("ingredient_type");
			svo.setWord(request.getParameter("word"));
			svo.setPage(1);
			svo.setPerpage(999);
			svo.setOrder("ingredient_num");
			svo.setDesc("");
			out.println(dao.list(svo));
			break;
		case "/home":
			request.setAttribute("pageName", "/info.jsp");
			dis=request.getRequestDispatcher("home.jsp");
			dis.forward(request, response);
			break;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();		
		
		
		switch(path){
		case "/refrigerator/insert":
			RefrigeratorVO vo=new RefrigeratorVO();			
			vo.setRefrigerator_userid(request.getParameter("refrigerator_userid"));
			vo.setRefrigerator_ingNum(Integer.parseInt(request.getParameter("refrigerator_ingNum")));
			vo.setRefrigerator_place(request.getParameter("refrigerator_place"));
			vo.setRefrigerator_date(request.getParameter("refrigerator_date"));
			String exDate=request.getParameter("refrigerator_exDate");
			if(exDate=="" || exDate==null){
				exDate=null;					
			}
			vo.setRefrigerator_exDate(exDate);
			vo.setRefrigerator_memo(request.getParameter("refrigerator_memo"));
			System.out.println(vo.toString());
			dao.insert(vo);			
			break;
		case "/refrigerator/update":
			vo=new RefrigeratorVO();
			vo.setRefrigerator_num(Integer.parseInt(request.getParameter("refrigerator_num")));
			vo.setRefrigerator_userid(request.getParameter("refrigerator_userid"));
			vo.setRefrigerator_ingNum(Integer.parseInt(request.getParameter("refrigerator_ingNum")));
			vo.setRefrigerator_place(request.getParameter("refrigerator_place"));
			vo.setRefrigerator_date(request.getParameter("refrigerator_date"));
			exDate=request.getParameter("refrigerator_exDate");
			if(exDate=="" || exDate==null){
				exDate=null;					
			}
			vo.setRefrigerator_exDate(exDate);
			vo.setRefrigerator_memo(request.getParameter("refrigerator_memo"));
			System.out.println(vo.toString());
			dao.update(vo);			
			break;
		}
		response.sendRedirect("/refrigerator/list");
	}
}