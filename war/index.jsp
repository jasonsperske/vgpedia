<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="net.vgpedia.*" %>
<%@ page import="net.vgpedia.models.*" %>
<%@ page import="net.vgpedia.views.*" %>
<%  UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    PersistenceManager pm = PMF.get().getPersistenceManager();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="net.vgpedia.views.NewsFactory"%>
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
<%	List<NewsItem> news = NewsFactory.fetchRecent(pm);
	if(!news.isEmpty()) {
		DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
		for (NewsItem news_item : news) {%>
			<h2><%=news_item.getTitle()%></h2>
			<span class="NewsItem"><%=news_item.getBody().getValue()%></span>
			<span class="NewsItem-date"><%=news_item.getFormattedPostedAt(formatter)%></span>
<%		}
	}%>
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