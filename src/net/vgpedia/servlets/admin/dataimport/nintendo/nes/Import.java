package net.vgpedia.servlets.admin.dataimport.nintendo.nes;

import java.io.IOException;
import java.io.PrintWriter;

import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

import net.vgpedia.PMF;
import net.vgpedia.models.GameNamer;
import net.vgpedia.models.nintendo.nes.NESGame;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.repackaged.org.json.JSONObject;

@SuppressWarnings("serial")
public class Import extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    String output = "";

	    try {
	    	JSONObject json = new JSONObject();
		    if (user != null) {
		    	if(userService.isUserAdmin()) {
					PersistenceManager pm = PMF.get().getPersistenceManager();
					try {
						boolean successful = false;
						String name = req.getParameter("title");
						if(name != null) {
							String guid = GameNamer.encode(name);
							if(guid != null) {
								String group = req.getParameter("group");
								String code = req.getParameter("code");
								NESGame game = new NESGame(guid, group, name, code);
								pm.makePersistent(game);
								successful = true;
							}
						}
						json.put("Success", successful);
			        } finally {
			            pm.close();
			        }
		    	}
		    }
		    output = json.toString();
	    } catch (Exception e) {
	    	output = "{\"Success\":false,\"Message\":\""+e.getLocalizedMessage()+"\"}";
		}

	    resp.setContentType("text/plain; charset=UTF-8");
	    PrintWriter writer = resp.getWriter();
	    writer.write(output);
	    writer.flush();
	}
}
