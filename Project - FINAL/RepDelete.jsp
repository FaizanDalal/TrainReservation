<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head><link rel = "stylesheet" type="text/css" href = "style.css">
    <title>Delete Train Schedule</title>
</head>
<body>

<form action="scheduleDelete.jsp" method="post"><br>
   <p> Enter the Train Number to delete from the database: <input type="text" name="rowNum"required><br>
   
    
    <input type="submit" value="Delete the reservation">
</form>
<form action="serviceRep.html" method = "post">
		<input type="submit" value="Return to home">
</form>
</body>
</html>