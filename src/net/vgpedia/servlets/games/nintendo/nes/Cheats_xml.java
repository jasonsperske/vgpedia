package net.vgpedia.servlets.games.nintendo.nes;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheat;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheatTypes;
import net.vgpedia.views.nintendo.nes.NESGameMemoryCheatsFactory;

import org.apache.commons.lang.StringEscapeUtils;

@SuppressWarnings("serial")
public class Cheats_xml extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	StringBuilder xml = new StringBuilder();

    	xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    	xml.append("<cheats version=\"1.0\">");

    	String guid = req.getParameter("guid");
		if(guid != null) {
			PersistenceManager pm = PMF.get().getPersistenceManager();
			NESGame game = pm.getObjectById(NESGame.class, guid);
			if(game != null) {
				List<NESGameMemoryCheat> cheats = NESGameMemoryCheatsFactory.fetch(game, pm);
				if(cheats != null) {
					if(!cheats.isEmpty()) {
						for (NESGameMemoryCheat cheat : cheats) {
							if(cheat.getCodetype() == NESGameMemoryCheatTypes.GAMEGENIE) {
								String[] codes = cheat.getCode().split("\\+");
								String escaped_desc = StringEscapeUtils.escapeXml(cheat.getDescription());
								if(codes.length == 1) {
									xml.append("<cheat enabled=\"0\">");
									xml.append("<genie>").append(codes[0]).append("</genie>");
									xml.append("<description>").append(escaped_desc).append("</description>");
									xml.append("</cheat>");
								} else {
									int index = 1;
									for(String code : codes) {
										xml.append("<cheat enabled=\"0\">");
										xml.append("<genie>").append(code).append("</genie>");
										xml.append("<description>").append(escaped_desc).append(" (").append(index++).append(" of ").append(codes.length).append(")</description>");
										xml.append("</cheat>");
									}
								}
							}
						}
					}
				}
			}
			pm.close();
		}
		xml.append("</cheats>");
    	
    	resp.setContentType("text/xml");
    	resp.getWriter().println(xml.toString());
    }
}