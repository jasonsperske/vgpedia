package net.vgpedia.servlets.admin.dataimport.nintendo.nes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
    				String[] import_data = req.getParameter("import").split("\r|\n|\r\n");

					List<JSONObject> games = new LinkedList<JSONObject>();
					for(String line : import_data) {
						if(line.length() > 0) {
							String[] data = line.split("\t");
							if(data.length == 3) {
								try {
									String group = data[0].toUpperCase();
									String title = data[1].trim();
									String code = data[2].trim();
									JSONObject json_game = new JSONObject();
									json_game.put("Group", group);
									json_game.put("Title", title);
									json_game.put("Code", code);
									games.add(json_game);
								} catch (Exception e) {}
							}
						}
					}
					json.put("Games", games);
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
