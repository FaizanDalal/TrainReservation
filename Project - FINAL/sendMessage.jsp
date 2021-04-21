<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message Sent</title>
<link rel="stylesheet" href="style.css">
</head> 
<body>
	<%
		
			String topic = request.getParameter("topic");
			String message = request.getParameter("message");
			String userN = (String)session.getAttribute("user");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
	    	Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
		    Statement st = con.createStatement();
		    
		    String query = "INSERT INTO Messages(username, topic, message) " 
		    	+ "VALUES (\'" + userN + "\', \'" + topic + "\', \"" + message + "\");";
		    st.executeUpdate(query);
		    st.close();
		    con.close();
		
	%>
	<form action="customer.html" method="post">
    	<button>Return home</button>
    </form>
</body>
</html>