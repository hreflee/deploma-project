package listener;

import java.sql.Connection;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import db.DBBean;
/**
 * @author 版本
 */
public class SessionTimeoutListener implements HttpSessionListener {

	public void sessionCreated(HttpSessionEvent event) {
	}
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
       String username = (String) session.getAttribute("user");
       Connection conn = null;
	   String sql = "";
	   conn = DBBean.getConnection();			
	   sql = "update table_user set isLoged=0 where username='" + username + "'";
	   DBBean.update(sql);
	}
}
