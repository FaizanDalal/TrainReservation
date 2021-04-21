<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head><link rel = "stylesheet" type="text/css" href = "style.css">
    <title>Get Customers</title>
</head>
<body>

<form action="CustResLine.jsp" method="post"><br>
   <p> Enter the Transit Line: <input type="text" name="lineT"required><br>
   <p> Enter the Reservation Date: <input type="text" name="resDate"required><br>
   
   
    
    <input type="submit" value="Get the Customers">
</form>
<form action="serviceRep.html" method = "post">
		<input type="submit" value="Return to home">
</form>
</body>
</html>