package net.vgpedia.servlets.admin.news;

import java.io.IOException;
import java.util.Date;
import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

import net.vgpedia.models.NewsItem;
import net.vgpedia.PMF;

import com.google.appengine.api.datastore.Text;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class Insert extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    String redirect = "/?err=Exception";

	    if (user != null) {
	    	if(userService.isUserAdmin()) {
				String title = req.getParameter("title");
				String body = req.getParameter("body");
		        Date postedAt = new Date();

		        NewsItem news_item = new NewsItem(title, new Text(body), postedAt);

		        PersistenceManager pm = PMF.get().getPersistenceManager();
		        try {
		            pm.makePersistent(news_item);
		            redirect = "/admin/news/?action=NewsPosted";
		        } finally {
		            pm.close();
		        }
	    	}
	    }

	    resp.sendRedirect(redirect);
	}
}
