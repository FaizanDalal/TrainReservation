<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Messages</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
	

	<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
	Statement s = con.createStatement();
	String userN = (String) session.getAttribute("user");
	
	
	%>

	<h3>Message a Representative</h3>
	<form action="sendMessage.jsp" method="post">
		<h5>Message topic:</h5>
		<input name="topic" type="text">
		<h5>Message:</h5>
		<input name="message" type="text" /> <br>
		<br>
		<button>Send</button>
	</form>
	<form action="customer.html">
		<button>Back to Home</button>
	</form>
	<br>
	
	<h3>Search Messages</h3>
	<form action="messageSearch.jsp" method="post">
		<h5>Search by Topic:</h5>
		<input name="searchTopic" type="text"><br>
		<button>Search</button>
	</form>
	<h3>View Messages</h3>
	<form action="messageView.jsp" method="post">
		<button>View</button>
	</form>

</body>
</html>