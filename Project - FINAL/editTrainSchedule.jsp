<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head><link rel = "stylesheet" type="text/css" href = "style.css">
    <title>Edit information to a train schedule!</title>
</head>
<body>

<form action="repEditSchedule.jsp" method="post"><br>
    <p>Enter the rowNum: <input type="text" name="rowNum"required><br>
   <p> Enter the new number of stops for the train: <input type="text" name="stops"required><br>
	<p>Enter the new length: <input type="text" name="length"required><br>
	<p>Enter the new line name: <input type="text" name="Line_lineName"required><br>
	<p>Enter the new arrival: <input type="text" name="arrival"required><br>
	<p>Enter the new departure: <input type="text" name="departure"required><br>
	<p>Enter the new date: <input type="text" name="date"required><br>
	
	
    <input type="submit" value="Edit the reservation">
	</form>

<form action="serviceRep.html" method="post">
    	<button>Return home</button>
    </form>
</body>
</html>