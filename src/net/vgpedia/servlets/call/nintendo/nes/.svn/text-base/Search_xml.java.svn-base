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
import net.vgpedia.views.nintendo.nes.NESGamesFactory;

@SuppressWarnings("serial")
public class Search_xml extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	StringBuilder xml = new StringBuilder();

    	xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    	String code = req.getParameter("Code");
    	xml.append("<Response>");
    	PersistenceManager pm = PMF.get().getPersistenceManager();
    	if(code != null) {
    		int index = Integer.parseInt(req.getParameter("Digits"));
    		List<NESGame> games = NESGamesFactory.fetchByPhoneCode(code, pm);
    		if(!games.isEmpty()) {
    			if(games.size() >= index) {
    				xml.append("<Redirect>/call/nintendo/game.xml?Game="+games.get(index-1).getGUID()+"</Redirect>");
    			}
    		}
    	} else {
    		code = req.getParameter("Digits");
			List<NESGame> games = NESGamesFactory.fetchByPhoneCode(code, pm);

			if(!games.isEmpty()) {
				if(games.size() == 1) {
					xml.append("<Redirect>/call/nintendo/game.xml?Game="+games.get(0).getGUID()+"</Redirect>");
				} else {
					xml.append("<Say>There are "+games.size()+" games that could match those letters.</Say>");
					xml.append("<Gather action='/call/nintendo/nes.xml?Code="+code+"' method='GET'>");
					int index = 1;
					for(NESGame game : games) {
						xml.append("<Say>For "+StringEscapeUtils.escapeXml(game.getTitle())+" press "+(index++) +" followed by the pound sign.</Say>");
					}
					xml.append("</Gather>");
				}
			} else {
				xml.append("<Say>I'm sorry there are no games in V G Pedia that are spelled with those letters.</Say>");				
			}
			
		}
    	pm.close();
		xml.append("</Response>");

		resp.setContentType("text/xml");
    	resp.getWriter().println(xml.toString());
    }
}

