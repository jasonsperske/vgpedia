package net.vgpedia.servlets.games.nintendo.nes.admin.cheat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheat;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheatTypes;
import net.vgpedia.views.nintendo.nes.NESGameMemoryCheatFactory;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.repackaged.org.json.JSONException;
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
	    		String guid = req.getParameter("guid");
	    		if(guid != null) {
	    			PersistenceManager pm = PMF.get().getPersistenceManager();
	    			try {
		    			NESGame game = pm.getObjectById(NESGame.class, guid);
		    			if(game != null) {
		    				boolean valid = false;
							String code = req.getParameter("code").trim();
							String description = req.getParameter("description").trim();
							if(code.length() > 0 && description.length() > 0) {
								NESGameMemoryCheatTypes codetype = NESGameMemoryCheatTypes.TIP;
								String codetype_name = req.getParameter("codetype"); 
								if(codetype_name.equals(NESGameMemoryCheatTypes.GAMEGENIE.toString())) {
									codetype = NESGameMemoryCheatTypes.GAMEGENIE;
									code = code.toUpperCase();
									Pattern pattern = Pattern.compile("([APZLGITYEOXUKSVN+])+");
									valid = pattern.matcher(code).matches();
								} else if(codetype_name.equals(NESGameMemoryCheatTypes.PROACTIONREPLAY.toString())) {
									codetype = NESGameMemoryCheatTypes.PROACTIONREPLAY;
								}

								if(valid) {
									NESGameMemoryCheat cheat = NESGameMemoryCheatFactory.fetch(game, code, codetype, pm);
									if(cheat != null) {
										cheat.setDescription(description);
										json.put("Updated", true);							
									} else {
										cheat = new NESGameMemoryCheat(game, code, description, codetype, user);
										json.put("Updated", false);
									}
									pm.makePersistent(cheat);
						            json.put("Success", true);
								} else {
									json.put("Success", false);
									json.put("Message", "Not A Valid Code");							
								}
							} else {
								json.put("Success", false);
								json.put("Message", "MissingRequiredField");
							}
		    			}
	    			} finally {
	    				pm.close();
	    			}
	    		}
		    }
		    output = json.toString();
		} catch(JSONException e) {
			output = "{\"Success\":false,\"Message\":\""+e.getLocalizedMessage()+"\"}";
		}

	    resp.setContentType("text/plain; charset=UTF-8");
	    PrintWriter writer = resp.getWriter();
	    writer.write(output);
	    writer.flush();
	}
}