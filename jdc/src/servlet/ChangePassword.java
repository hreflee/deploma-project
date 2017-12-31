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
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ConnectionPoolAdapter dbPool;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePassword() {
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
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		String username = (String) session.getAttribute("user");
		String oldPassword = request.getParameter("oldPassword");
		String password1 = request.getParameter("password");
		String password2 = request.getParameter("password2");
		int userType = Integer.parseInt(request.getParameter("userType"));
		
		if(username == null || oldPassword == null || password1 == null || password2 == null){			
			request.getRequestDispatcher("changePassword.jsp").forward(
					request, response);
			return;
		}
		int result = -3;
		if (password1 != null && password2 != null) {
			if (password1.indexOf("=") != -1 || password2.indexOf("=") != -1
					|| password1.indexOf("&") != -1
					|| password2.indexOf("&") != -1
					|| password1.indexOf("'") != -1
					|| password2.indexOf("'") != -1) {
				result = -2;//非法字符
			}
			else {
				UserMgr usermgr = new UserMgr();
				result = usermgr.changePassword(username, oldPassword, password1);
			}
		}
		String priv = "" + result;
		switch (result) {
		case -1:// wrong old password
			if(userType == 0){
				request.getRequestDispatcher("../student/changePassword.jsp?msg=原有密码输入有误！").forward(
					request, response);
			}
			else if(userType == 1){
				request.getRequestDispatcher("../teacher/changePassword.jsp?msg=原有密码输入有误！").forward(
						request, response);
			}
			break;
		case 1:// 非法字符
			if(userType == 0){
				request.getRequestDispatcher("../student/main.jsp").forward(
					request, response);
			}
			else if(userType == 1){
				request.getRequestDispatcher("../teacher/main.jsp").forward(
					request, response);
			}
			break;
		case -2:// wrong old password
				request.getRequestDispatcher("../student/changePassword.jsp?msg=密码有非法字符！").forward(
						request, response);
				break;
		}
	}

}
