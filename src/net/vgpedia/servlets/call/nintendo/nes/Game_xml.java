package net.vgpedia.servlets.call.nintendo.nes;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameImage;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheat;
import net.vgpedia.views.nintendo.nes.NESGameImagesFactory;
import net.vgpedia.views.nintendo.nes.NESGameMemoryCheatsFactory;

@SuppressWarnings("serial")
public class Game_xml extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	StringBuilder xml = new StringBuilder();

    	xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    	String guid = req.getParameter("Game");
    	xml.append("<Response>");
    	PersistenceManager pm = PMF.get().getPersistenceManager();
    	if(guid != null) {
    		NESGame game = pm.getObjectById(NESGame.class, guid);
    		if(game != null) {
    			List<NESGameImage> roms = NESGameImagesFactory.fetch(game, pm);
    			List<NESGameMemoryCheat> cheats = NESGameMemoryCheatsFactory.fetch(game, pm);
    			
    			xml.append("<Say>"+StringEscapeUtils.escapeXml(game.getTitle())+"</Say>");
    			if(roms.size() > 1) {
    				xml.append("<Say>So far we have found "+roms.size()+" unique images of this game</Say>");    				
    			} else if(roms.size() == 1) {
    				xml.append("<Say>So far we have only found 1 unique image of this game</Say>");
    			} else {
    				xml.append("<Say>So far we have not found any unique images of this game</Say>");
    			}
    			
    			if(cheats.size() > 0) {
    				if(cheats.size() == 1) {
    					xml.append("<Say>So far we have found only 1 game genie code for "+StringEscapeUtils.escapeXml(game.getTitle())+". Why don't you head over to w w w dot v g pedia dot net and contribute?</Say>");
    				} else {
    					xml.append("<Say>So far we have found "+cheats.size()+" game genie codes for "+StringEscapeUtils.escapeXml(game.getTitle())+".</Say>");    					
    				}
    				for(NESGameMemoryCheat cheat : cheats) {
    					String[] code_parts = cheat.getCode().split("\\+");
    					if(code_parts.length > 1) {
    						xml.append("<Say>The following code has "+code_parts.length+" parts</Say>");    						
    					}
    					xml.append("<Say>Use the code "+cheat.getCode()+" to "+StringEscapeUtils.escapeXml(cheat.getDescription())+"</Say>");	    					
    				}
    			} else {
    				xml.append("<Say>Unfortunatly there are no game genie codes for "+StringEscapeUtils.escapeXml(game.getTitle())+" in V G Pedia dot net.  Why don't you head over to w w w dot v g pedia dot net and contribute?</Say>");    				
    			}
    		}
		}
    	pm.close();
		xml.append("</Response>");

		resp.setContentType("text/xml");
    	resp.getWriter().println(xml.toString());
    }
}
