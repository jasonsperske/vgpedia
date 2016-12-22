<%@ page contentType="text/xml;charset=UTF-8" language="java" %>
<Response>
	<Say>Welcome to the V G Pedia Power Line!</Say>
	<Gather action="/call/nintendo/nes.xml" method="GET">
		<Say>Please enter the first 5 letters or numbers of the game you are looking for, followed by the pound sign.  If the game you are looking for is shorter than 5 letters simply press pound when you are done</Say>	
	</Gather>
	<Say>I'm sorry we did not receive any input. Goodbye!</Say>
</Response>