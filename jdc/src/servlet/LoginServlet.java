package servlet;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.ConnectionPoolAdapter;

import entity.*;
import db.*;

/**
 * Servlet implementation class Login
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ConnectionPoolAdapter dbPool;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		//not normal visit, null value, return
		if(username == null || password == null){			
			request.getRequestDispatcher("../index.jsp").forward(
					request, response);
			return;
		}
		int result = -4;
		if (username != null && password != null) {
			if (username.indexOf("=") != -1 || password.indexOf("=") != -1
					|| username.indexOf("&") != -1
					|| password.indexOf("&") != -1
					|| username.indexOf("'") != -1
					|| password.indexOf("'") != -1) {
				result = -3;//非法字符
			}
			else {
				UserMgr usermgr = new UserMgr();
				result = usermgr.verifyUser(username, password);
			}
		}
		String priv = "" + result;
		HttpSession session = request.getSession();
		switch (result) {
		case -5:// 已经登录
			response.sendRedirect("../index.jsp?loged=yes&error=" + java.net.URLEncoder.encode("重复登录！或上次登录未注销。<br>请输正确的用户名点击注销上次登录后再试","utf-8"));
			break;
		case -4:// 没有输入
			response.sendRedirect("../index.jsp");
			break;
		case -3:// 非法字符
			response.sendRedirect("../index.jsp?error=" + java.net.URLEncoder.encode("有非法字符！","utf-8"));
			break;
		case -2:// 密码错误
			response.sendRedirect("../index.jsp?error=" + java.net.URLEncoder.encode("密码错误","utf-8"));
			break;
		case -1:// 用户错误
			response.sendRedirect("../index.jsp?error=" + java.net.URLEncoder.encode("用户名错误！","utf-8"));
			break;
		case 0:// 学生用户
			session.setAttribute("priv", priv);
			session.setAttribute("user", username);
			request.getRequestDispatcher("../student/main.jsp").forward(
					request, response);;
			break;
		case 1:// 教师用户
			session.setAttribute("priv", priv);
			session.setAttribute("user", username);
			response.sendRedirect("../teacher/main.jsp");
			break;
		case 2:// 管理员用户
			session.setAttribute("priv", priv);
			session.setAttribute("user", username);
			response.sendRedirect("../admin/main.jsp");
		}
		System.out.println(username + "登录");
	}

}
