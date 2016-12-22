package net.vgpedia.servlets.search.games.nintendo.nes;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.vgpedia.PMF;
import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.views.nintendo.nes.NESGameFactory;

import org.apache.commons.lang.StringEscapeUtils;

@SuppressWarnings("serial")
public class Search_xml  extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	StringBuilder xml = new StringBuilder();

    	xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    	xml.append("<results version=\"1.0\">");

    	String crc = req.getParameter("crc");
		if(crc != null) {
			PersistenceManager pm = PMF.get().getPersistenceManager();
			List<NESGame> games = NESGameFactory.findByCrc(crc, pm);

			if(!games.isEmpty()) {
				for(NESGame game : games) {
					xml.append("<game url=\"http://www.vgpedia.net/games/nintendo/nes/").append(game.getGUID()).append(".html\">").append(StringEscapeUtils.escapeXml(game.getTitle())).append("</game>");
				}
			}
			pm.close();
		}

		xml.append("</results>");
    	resp.setContentType("text/xml");
    	resp.getWriter().println(xml.toString());
    }
}
