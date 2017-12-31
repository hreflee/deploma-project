package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.UserMgr;

public class Register extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Register() {
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
		String studentname = request.getParameter("studentName");
		String pairname = request.getParameter("pairname");
		String password = request.getParameter("password");
		String catagloryID[]=request.getParameterValues("catagloryID");
		if(studentname == null || pairname == null || password == null || catagloryID == null){			
			request.getRequestDispatcher("../register.jsp").forward(
					request, response);
			return;
      	}
		 int len=catagloryID.length;
		 int cataID[]=new int[len];
		 for(int i=0;i<len;i++){
			 cataID[i]=Integer.parseInt(catagloryID[i]);
		 }
		 UserMgr userMgr = new UserMgr();
		 int result = userMgr.register(studentname, pairname, password, cataID);
		 if(result == -1){
			 response.sendRedirect("../register.jsp?error=" + java.net.URLEncoder.encode("名字冲突，请重填。","utf-8"));
		 }
		 else{
			 response.sendRedirect("../index.jsp");
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
