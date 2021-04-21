<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head><link rel = "stylesheet" type="text/css" href = "style.css">
    <title>Get Train Schedules</title>
</head>
<body>

<form action="getOriginDestination.jsp" method="post"><br>
   <p> Enter the Origin: <input type="text" name="originT"required><br>
   <p> Enter the Destination: <input type="text" name="destinationT"required><br>
   
   
    
    <input type="submit" value="Get the Schedules">
</form>
<form action="serviceRep.html" method = "post">
		<input type="submit" value="Return to home">
</form>
</body>
</html>