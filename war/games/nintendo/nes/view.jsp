<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="net.vgpedia.*" %>
<%@ page import="net.vgpedia.models.nintendo.nes.*" %>
<%@ page import="net.vgpedia.views.nintendo.nes.NESGameImagesFactory"%>
<%@ page import="net.vgpedia.views.nintendo.nes.NESGameMemoryCheatsFactory"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();   
	PersistenceManager pm = PMF.get().getPersistenceManager();
	String guid = request.getParameter("guid");
	if(guid != null) {
		NESGame game = pm.getObjectById(NESGame.class, guid);
		if(game != null) {
			List<NESGameImage> roms = NESGameImagesFactory.fetch(game, pm);
			List<NESGameMemoryCheat> cheats = NESGameMemoryCheatsFactory.fetch(game, pm);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title><%=game.getTitle()%> (NES) - VGPedia.net</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<link rel="stylesheet" type="text/css" media="screen" href="/stylesheets/main.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="/stylesheets/ui-lightness/jquery-ui-1.7.2.custom.css" />
		<link rel="shortcut icon" type="image/gif" href="/images/favicon.gif" />
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js" type="text/javascript"></script>
		<script src="/scripts/wtooltip.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#dialog').dialog({ title: 'Add a cheat code', modal: true, autoOpen: false });
<%	if(roms != null) {
		if(!roms.isEmpty()) {
			DecimalFormat df = new DecimalFormat();
			for (NESGameImage rom : roms) { %>
				$("#rom_<%=KeyFactory.keyToString(rom.getKey())%>").wTooltip({content: "<b>size:<\/b><%=df.format(rom.getSize()) %> bytes<br\/><b>crc:<\/b><%=rom.getCrc() %>"});
<%			}
		}
	}%>
			});
	</script>
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
				(<a href="<%= userService.createLogoutURL("/games/nintendo/nes/"+game.getGUID()+".html") %>">sign out</a>)
<% 		if(userService.isUserAdmin()) {%>
				(<a href="/admin/">admin</a>)
<%		} %>
<%  } else {%>
			<a href="<%= userService.createLoginURL("/games/nintendo/nes/"+game.getGUID()+".html") %>">Sign in</a>
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
			<h2><%=game.getTitle()%></h2>
			<table class="Stats">
				<colgroup>
					<col width="100" />
					<col />
				</colgroup>
				<tbody>
<%	if(roms != null) {
		if(!roms.isEmpty()) {%>
					<tr>
						<td class="Label">ROMs:</td>
						<td>
							<dl>
<%			for (NESGameImage rom : roms) { %>
								<dt id="rom_<%=KeyFactory.keyToString(rom.getKey())%>"><%=rom.getTitle() %></dt>
<%			} %>
							</dl>
						</td>
					</tr>
<%		}
	}%>
<%	if (user != null) {
 		if(userService.isUserAdmin()) {%>
					<tr>
						<td class="Label">Actions:</td>
						<td>
							<a href="/games/nintendo/nes/<%=game.getGUID()%>/admin/rom/">Import ROMs</a>
							<a href="/games/nintendo/nes/<%=game.getGUID()%>/admin/cheat/">Import Cheats</a>
						</td>
					</tr>
<%		}
	}%>
				</tbody>
			</table>
			<table class="Data">
				<thead>
					<tr>
						<th>Code</th>
						<th>Description</th>
						<th>Type</th>
					</tr>
				</thead>
				<tbody>
<%	if(cheats != null) {
		if(!cheats.isEmpty()) {
			for (NESGameMemoryCheat cheat : cheats) { %>
					<tr>
						<td><%=cheat.getCode()%></td>
						<td><%=StringEscapeUtils.escapeHtml(cheat.getDescription())%></td>
						<td><%=cheat.getCodetype()%></td>
					</tr>
<%			}
		}
	}%>
					<tr class="Navigate">
						<td colspan="3">
<%	if(cheats != null) {
		if(!cheats.isEmpty()) {%>
							(<a href="<%=game.getGUID()%>.xml">Download as XML</a>)
<%		}
	}%>
							(<a href="#" onclick="$('#dialog').dialog('open'); return false;" >Add cheat</a>)
						</td>
					</tr>
				</tbody>
			</table>
			<div id="dialog" style="display: none;">
<%	if (user != null) { %>
				<form action="/games/nintendo/nes/cheat/Insert" method="post">
					<input type="hidden" name="guid" value="<%=game.getGUID()%>" />
					<div><input name="code" type="text" size="43" /></div>
					<div><textarea name="description" rows="3" cols="40"></textarea></div>
					<div>
						<select name="codetype">
							<option><%=NESGameMemoryCheatTypes.GAMEGENIE %></option>
						</select>
					</div>
					<div><input type="submit" value="Add cheat" /></div>
				</form>
<%	} else { %>
				<p>In order to add your own codes you need to sign in.  Don't worry, it's easy, in fact if you have a Google Account (GMail, iGoogle, YouTube) already you can just use that.</p>
<%	} %>
			</div>
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
<%  	} else {
      		response.sendRedirect("/games/nintendo/nes/?err=ObjectNotFound");
      	}
	} else {
		response.sendRedirect("/games/nintendo/nes/?err=KeyNotFound");
  	}
 	pm.close();%>