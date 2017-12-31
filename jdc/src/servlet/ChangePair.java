package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.UserMgr;

public class ChangePair extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ChangePair() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		processRequest(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		processRequest(request, response);
	}
	
	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String studentname = "";
		if(session != null){
			studentname = (String) session.getAttribute("user");
		}
		else{
			request.getRequestDispatcher("../index.jsp").forward(
					request, response);
			return;
		}
		String newPairname = request.getParameter("pairname");
		String password = request.getParameter("password");
		//not normal visit, null value, return
		if(newPairname == null || password == null){	
			request.getRequestDispatcher("../index.jsp").forward(
					request, response);
			return;
		}
		 UserMgr userMgr = new UserMgr();
		 int result = userMgr.changePair(studentname, newPairname, password);
		 if(result == -1){
			 response.sendRedirect("../student/changePair.jsp?error=" + java.net.URLEncoder.encode("新帮背人名字和已有用户冲突，请重填。","utf-8"));
		 }
		 else{
			 response.sendRedirect("../student/main.jsp");
		 }
			
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
