<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory,
				 com.google.appengine.api.users.User,
				 com.google.appengine.api.users.User,
				 com.google.appengine.api.users.UserService,
				 com.google.appengine.api.users.UserServiceFactory" %>
<%  UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
    	if(userService.isUserAdmin()) {%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>VGPedia.net</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<link rel="stylesheet" type="text/css" media="screen" href="/stylesheets/main.css" />
		<link rel="shortcut icon" type="image/gif" href="/images/favicon.gif" />
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			function escape(value) {
				return value.replace(/"/g, "\&quot;");
			};
			$(function() {
				$("#ActionImport").click(function() {
					$.ajax({
						type: "POST",
						url: "/admin/dataimport/nintendo/nes/Convert",
						data: $("#Import").serialize(),
						dataType: "json",
						success: function(data) {
							var output = [];
							output.push("<form class='Games' onsubmit='return false;'><input type='submit' name='action' value='Save All' /></form>");
							jQuery.each(data.Games, function() {
								output.push("<form class='Game' onsubmit='return false;'>");
								output.push("<input type='submit' name='action' value='Save' />");
								output.push("<input type='text' name='group' value=\""+this.Group+"\" size='10'/>");
								output.push("<input type='text' name='title' value=\""+escape(this.Title)+"\" size='55'/>");
								output.push("<input type='text' name='code' value=\""+this.Code+"\" size='5'/>");
								output.push("</form>");
							});
							$("#Converted").html(output.join(""));
					    }
					});
					return false;
			    });
				$('form.Games').live('submit', function() {
					var submit_buttons = $("form.Game input[type='submit']"),
					    save_game = function(games, index) {
					    	var submit_button = $(games[index]),
					    		row = submit_button.parent(),
					    		self = arguments.callee;
							$.ajax({
								type: "POST",
								url: "/admin/dataimport/nintendo/nes/Import",
								data: row.serialize(),
								dataType: "json",
								success: function(data) {
									if(data.Success) {
										row.remove();
									} else {
										submit_button.attr("disabled", false);
										submit_button.val("Saving");
									}
									if(index < games.length) {
										self(games, index+1);
									} else {
										$('#Converted').empty();
									}
								}
							});
					    };
					submit_buttons.attr("disabled", true);
					submit_buttons.val("Saving");
					save_game(submit_buttons, 0);
				});
				$('form.Game').live('submit', function() {
					var row = $(this),
						submit_button = row.find("input[type='submit']");
					submit_button.attr("disabled", true);
					$.ajax({
						type: "POST",
						url: "/admin/dataimport/nintendo/nes/Import",
						data: row.serialize(),
						dataType: "json",
						success: function(data) {
							if(data.Success) {
								if(data.Updated) {
									row.html("<b>Updated!</b>");
								} else {
									row.html("<b>Saved!</b>");
								}
								row.stop().css("background-color", "#FFFF9C").animate({ backgroundColor: "#FFFFFF"}, 1500);
								row.fadeOut('slow');
							} else {
								alert(data.Message);
								submit_button.attr("disabled", false);
							}
					    }
					});
				});
			});
		</script>
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
			<h1>Import Data</h1>
			<h2>Add a new NES Games (one per line)</h2>
			<pre>GROUP &lt;tab&gt; TITLE &lt;tab&gt; PHONE CODE</pre>
		    <form onsubmit='return false;' id="Import">
				<div><textarea name="import" rows="3" cols="60"></textarea></div>
				<div><input type="submit" value="Import Games" id="ActionImport" /></div>
			</form>
			<div id="Converted"></div>
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
<%		} else {
			response.sendRedirect("/admin/denied.html");
		}
	} else {
    	response.sendRedirect(userService.createLoginURL(request.getRequestURI()));
    }%>