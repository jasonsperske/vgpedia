package net.vgpedia.servlets.admin.news;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.NewsItem;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class Update extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    String redirect = "/?err=Exception";

	    if (user != null) {
	    	if(userService.isUserAdmin()) {
	    		PersistenceManager pm = PMF.get().getPersistenceManager();
	    		Key key = KeyFactory.stringToKey(req.getParameter("key"));
	    		if(key != null) {
	    			NewsItem news_item = pm.getObjectById(NewsItem.class, key);
	    			if(news_item != null) {
	    				news_item.setTitle(req.getParameter("title"));
	    				news_item.setBody(new Text(req.getParameter("body")));

			            redirect = "/admin/news/?action=NewsUpdated";
	    			}
	    		}
	    		pm.close();
	    	}
	    }

        resp.sendRedirect(redirect);
	}
}
