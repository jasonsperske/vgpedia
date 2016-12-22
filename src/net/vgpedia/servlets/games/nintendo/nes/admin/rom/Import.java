package net.vgpedia.servlets.games.nintendo.nes.admin.rom;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameImage;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class Import extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    String redirect = "/?err=Exception";

	    if (user != null) {
	    	if(userService.isUserAdmin()) {
	    		String guid = req.getParameter("guid");
	    		if(guid != null) {
	    			PersistenceManager pm = PMF.get().getPersistenceManager();
	    			NESGame game = pm.getObjectById(NESGame.class, guid);
	    			if(game != null) {
	    				String[] import_data = req.getParameter("import").split("\r|\n|\r\n");

						try {
							for(String line : import_data) {
								if(line.length() > 0) {
									String[] data = line.split("\t");
									if(data.length == 3) {
										try {
										    String title = data[0];
										    long size = Long.parseLong(data[1]);
										    String crc = data[2];

											NESGameImage rom = new NESGameImage(game, title, size, crc);
											pm.makePersistent(rom);
										} catch (Exception e) {}
									}
								}
							}
				        } finally {
				        	pm.close();
				            redirect = "/games/nintendo/nes/"+game.getGUID()+".html?action=ROMsImported";
				        }
	    			} else {
	    				redirect = "/games/nintendo/nes/?error=FindingGame";	    				
	    			}
	    		} else {
	    			redirect = "/games/nintendo/nes/?error=MissingKey";
	    		}
	    	}
	    }

	    resp.sendRedirect(redirect);
	}
}
