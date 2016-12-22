<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.*" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="net.vgpedia.*" %>
<%@ page import="net.vgpedia.models.*" %>
<%  UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
    	if(userService.isUserAdmin()) {
    		PersistenceManager pm = PMF.get().getPersistenceManager();
    		Key key = KeyFactory.stringToKey(request.getParameter("key"));
    		if(key != null) {
    			NewsItem news_item = pm.getObjectById(NewsItem.class, key);
    			if(news_item != null) {%>
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
			<a href="/"><img src="/images/vgpedia.logo.jpg" alt="VGPedia.net" /></a>
		</div>
		<div id="Menu">
			<ul>
				<li><a href="/">News</a></li>
				<li><a href="/games/">Games</a></li>
			</ul>
		</div>
		<div id="Profile">
			<p>
				<%= user.getNickname() %>
				(<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>)
				(<a href="/admin/">admin</a>)
			</p>
		</div>
		<div id="Sponsor">
			<img src="http://code.google.com/appengine/images/appengine-silver-120x30.gif" alt="Powered by Google App Engine" />
			Source Code found at <a href="https://code.google.com/p/vgpedia/"><img src="/images/google_code_tiny.png" alt="Google Code"/></a>
		</div>
		<div id="Content">
			<h1><a href="/admin/news/">News</a></h1>
			<h2>Edit post!</h2>
		    <form action="/admin/news/Update" method="post">
		    	<input type="hidden" name="key" value="<%=KeyFactory.keyToString(key)%>" />
				<div><input name="title" type="text" size="79" value="<%=news_item.getTitle()%>"/></div>
				<div><textarea name="body" rows="3" cols="60"><%=news_item.getBody().getValue()%></textarea></div>
				<div><input type="submit" value="Update News" /></div>
			</form>
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
<%    	   		} else {
        			response.sendRedirect("/admin/news/?err=ObjectNotFound");
        		}
			} else {
				response.sendRedirect("/admin/news/?err=KeyNotFound");
    		}
    		pm.close();
    	} else {
			response.sendRedirect("/admin/denied.html");
		}
	} else {
    	response.sendRedirect(userService.createLoginURL(request.getRequestURI()));
    }%>