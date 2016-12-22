package net.vgpedia.servlets.admin.dataimport.nintendo.nes.roms;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameImage;
import net.vgpedia.views.nintendo.nes.NESGameFactory;

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
						List<NESGame> games = NESGameFactory.findByTitle(req.getParameter("game"), pm);
						if(games != null && !games.isEmpty() && games.size() == 1) {
							try {
							    String title = req.getParameter("title");
							    long size = Long.parseLong(req.getParameter("size"));
							    String crc = req.getParameter("crc");

								NESGameImage rom = new NESGameImage(games.get(0), title, size, crc);
								pm.makePersistent(rom);
								successful = true;
							} catch (Exception e) {}
						}
						json.put("Success", successful);
			        } finally {
			            pm.close();
			        }
			        output = json.toString();
		    	}
		    }
	    } catch (Exception e) {
	    	output = "{\"Success\":false,\"Message\":\""+e.getLocalizedMessage()+"\"}";
		}

	    resp.setContentType("text/plain; charset=UTF-8");
	    PrintWriter writer = resp.getWriter();
	    writer.write(output);
	    writer.flush();
	}
}
