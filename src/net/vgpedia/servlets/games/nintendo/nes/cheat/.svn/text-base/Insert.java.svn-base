package net.vgpedia.servlets.games.nintendo.nes.cheat;

import java.io.IOException;
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

@SuppressWarnings("serial")
public class Insert extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String redirect = "/?err=Exception";

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
								String action = "";
								if(cheat != null) {
									cheat.setDescription(description);
									action = "CheatUpdated";
								} else {
									cheat = new NESGameMemoryCheat(game, code, description, codetype, user);
									action = "CheatAdded";
								}
					            pm.makePersistent(cheat);
					            redirect = "/games/nintendo/nes/"+game.getGUID()+".html?action="+action;
							} else {
								redirect = "/games/nintendo/nes/"+game.getGUID()+".html?error=NotAValidCode";							
							}
						} else {
							redirect = "/games/nintendo/nes/"+game.getGUID()+".html?error=MissingRequiredField";
						}
	    			}
    			} finally {
    				pm.close();
    			}
    		}
	    }
    	resp.sendRedirect(redirect);
	}
}