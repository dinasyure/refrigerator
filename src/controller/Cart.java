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

@WebServlet(value={"/cart/list","/cart/list.json","/cart/insert","/cart/delete", "/cartdelete"})
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	IngredientDAO dao=new IngredientDAO();
	CartDAO cdao=new CartDAO();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");		
		PrintWriter out=response.getWriter();
		String path=request.getServletPath();
		RequestDispatcher dis=null;
		
		switch(path){
		case "/cartdelete":
			cdao.delete(Integer.parseInt(request.getParameter("cart_num")));
			response.sendRedirect("myinfo");
			break;
		case "/cart/delete":
			cdao.delete(Integer.parseInt(request.getParameter("cart_num")));
			response.sendRedirect("list");
			break;
		case "/cart/insert":
			request.setAttribute("vo", dao.read(request.getParameter("ingredient_num")));			
			request.setAttribute("pageName", "/cart/insert.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/cart/list":
			request.setAttribute("pageName", "/cart/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/cart/list.json":
			HttpSession session=request.getSession();
			UserVO userVO=(UserVO)session.getAttribute("user");
			String id=userVO==null ? "" : userVO.getUid();
			System.out.println("id..............." + id);
			out.println(cdao.List(id));
			break;
		}	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();
		
		CartVO vo=new CartVO();		
		vo.setCart_userid(request.getParameter("cart_userid"));
		vo.setCart_ingNum(Integer.parseInt(request.getParameter("cart_ingNum")));
		vo.setCart_place(request.getParameter("cart_place"));		
		vo.setCart_memo(request.getParameter("cart_memo"));
		System.out.println(vo.toString());
		
		switch(path){
		case "/cart/insert":
			cdao.insert(vo);			
			break;		
		}
		response.sendRedirect("/cart/list");	
	}

}
