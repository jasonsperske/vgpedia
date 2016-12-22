package net.vgpedia.servlets.games.nintendo.nes.admin.cheat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.repackaged.org.json.JSONException;
import com.google.appengine.repackaged.org.json.JSONObject;

@SuppressWarnings("serial")
public class Convert extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    String output = "";

	    try {
	    	JSONObject json = new JSONObject();
		    if (user != null) {
		    	if(userService.isUserAdmin()) {
		    		String guid = req.getParameter("guid");
		    		if(guid != null) {
		    			PersistenceManager pm = PMF.get().getPersistenceManager();
		    			NESGame game = pm.getObjectById(NESGame.class, guid);
		    			if(game != null) {
		    				String[] import_data = req.getParameter("import").split("\r|\n|\r\n");

							try {
								List<JSONObject> codes = new LinkedList<JSONObject>();
								for(String line : import_data) {
									if(line.length() > 0) {
										String[] data = line.split("\\s", 2);
										if(data.length == 2) {
											try {
												String code = data[0].toUpperCase();
												String description = data[1].trim();
												JSONObject json_code = new JSONObject();
												json_code.put("Code", code);
												json_code.put("Description", description);
												codes.add(json_code);
											} catch (Exception e) {}
										}
									}
								}
								json.put("Codes", codes);
					        } finally {
					        	pm.close();
					        }
		    			}
		    		}
		    	}
		    }
		    output = json.toString();
		} catch(JSONException e) {
			output = "{\"Error\":true,\"Message\":\""+e.getLocalizedMessage()+"\"}";
		}

	    resp.setContentType("text/plain; charset=UTF-8");
	    PrintWriter writer = resp.getWriter();
	    writer.write(output);
	    writer.flush();
	}
}