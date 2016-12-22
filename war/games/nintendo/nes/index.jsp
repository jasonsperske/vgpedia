<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="net.vgpedia.*" %>
<%@ page import="net.vgpedia.models.nintendo.nes.*" %>
<%@ page import="net.vgpedia.views.DataPage" %>
<%@ page import="net.vgpedia.views.nintendo.nes.*" %>
<%  UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    PersistenceManager pm = PMF.get().getPersistenceManager();
    DataPage data_page = new DataPage(50, request);
    String group = request.getParameter("group");
    List<NESGame> games = null;

    if(group != null) {
		games = NESGamesFactory.fetch(data_page, group, pm);
	}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>VGPedia.net</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<link rel="stylesheet" type="text/css" media="screen" href="/stylesheets/main.css" />
		<link rel="shortcut icon" type="image/gif" href="/images/favicon.gif" />
	</head>
	<body>
		<div id="Logo">
			<a href="/"><img src="/images/vgpedia.logo.jpg" alt="VGPedia.net"/></a>
		</div>
		<div id="Menu">
			<ul>
				<li><a href="/">News</a></li>
				<li><a href="/games/">Games</a></li>
			</ul>
		</div>
		<div id="Profile">
			<p>
<%	if (user != null) { %>
				<%= user.getNickname() %>
				(<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>)
<% 		if(userService.isUserAdmin()) {%>
				(<a href="/admin/">admin</a>)
<%		} %>
<%  } else {%>
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
<%  }%>
			</p>
			<div id="google_translate_element"></div>
			<script>
				function googleTranslateElementInit() {
				  new google.translate.TranslateElement({
				    pageLanguage: 'en'
				  }, 'google_translate_element');
				}
			</script>
			<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
		</div>
		<div id="Sponsor">
			<img src="http://code.google.com/appengine/images/appengine-silver-120x30.gif" alt="Powered by Google App Engine" />
			Source Code found at <a href="https://code.google.com/p/vgpedia/"><img src="/images/google_code_tiny.png" alt="Google Code"/></a>
		</div>
		<div id="Content">
			<h1><a href="/games/">Games</a> &rArr; Nintendo &rArr; <a href="/games/nintendo/nes/">NES</a></h1>
			<a href="?group=0">#</a>|
			<a href="?group=A">A</a>|
			<a href="?group=B">B</a>|
			<a href="?group=C">C</a>|
			<a href="?group=D">D</a>|
			<a href="?group=E">E</a>|
			<a href="?group=F">F</a>|
			<a href="?group=G">G</a>|
			<a href="?group=H">H</a>|
			<a href="?group=I">I</a>|
			<a href="?group=J">J</a>|
			<a href="?group=K">K</a>|
			<a href="?group=L">L</a>|
			<a href="?group=M">M</a>|
			<a href="?group=N">N</a>|
			<a href="?group=O">O</a>|
			<a href="?group=P">P</a>|
			<a href="?group=Q">Q</a>|
			<a href="?group=R">R</a>|
			<a href="?group=S">S</a>|
			<a href="?group=T">T</a>|
			<a href="?group=U">U</a>|
			<a href="?group=V">V</a>|
			<a href="?group=W">W</a>|
			<a href="?group=X">X</a>|
			<a href="?group=Y">Y</a>|
			<a href="?group=Z">Z</a>
<%	if(group != null) { %>
			<table class="Data">
				<colgroup>
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>Title</th>
					</tr>
				</thead>
				<tbody>
					<tr class="Navigate">
						<td>
<%		if(games != null) {
			if(!games.isEmpty()) {
				if(data_page.hasPrevious()) { %>
							<a href="?group=<%=group %>&page=<%=data_page.getPage()-1 %>"><%=data_page.getPreviousDesc() %></a>
<%				} else { %>
							<%=data_page.getPreviousDesc() %>
<%				} %>
							<span class="Range"><%=data_page.getRangeDesc(games.size()) %></span>
<%				if(data_page.hasNext(games.size())) { %>
							<a href="?group=<%=group %>&page=<%=data_page.getPage()+1 %>"><%=data_page.getNextDesc() %></a>
<%				} else { %>
							<%=data_page.getNextDesc() %>
<%				}
			}
		}%>
						</td>
					</tr>
<%		if(games != null) {
			if(!games.isEmpty()) {
				int index = 0;
				for (NESGame game : games) {
					if(data_page.notLast(index++)) {%>
					<tr>
						<td><a href="<%=game.getGUID()%>.html"><%=game.getTitle()%></a></td>
					</tr>
<%					}
				}
			}
		}%>
					<tr class="Navigate">
						<td>
<%		if(games != null) {
			if(!games.isEmpty()) {
				if(data_page.hasPrevious()) { %>
							<a href="?group=<%=group %>&page=<%=data_page.getPage()-1 %>"><%=data_page.getPreviousDesc() %></a>
<%				} else { %>
							<%=data_page.getPreviousDesc() %>
<%				} %>
							<span class="Range"><%=data_page.getRangeDesc(games.size()) %></span>
<%				if(data_page.hasNext(games.size())) { %>
							<a href="?group=<%=group %>&page=<%=data_page.getPage()+1 %>"><%=data_page.getNextDesc() %></a>
<%				} else { %>
							<%=data_page.getNextDesc() %>
<%				}
			}
		}%>
						</td>
					</tr>
				</tbody>
			</table>
<%	} %>
		</div>
		<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-11943442-1");
pageTracker._trackPageview();
} catch(err) {}</script>
	</body>
</html>
<%	pm.close();%>