<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.util.Collections"%>
<%@ page import ="java.util.Iterator"%>
<%@ page import ="java.util.*"%>


<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");

%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./style/style.css">
<title>SpeedyTransit</title>


</head>

<body>
		<div class="SpeedyLogo"></div>
		
		<div class="navbar">

	  		<a href="customer.html">Home</a>
	 		<a href="reservation.jsp">Reservations</a>
			<a href="schedule.jsp">Train Schedules</a>
			<a class = "active" href="contact.jsp">Contact Us</a>
			<a href="logout.jsp">Logout</a>
		
		</div>
		
		<br><div class="backgroundPhoto uc"></div>		
		
		

				
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>