<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet"
		href=style.css>
</head>
<body>
<h3>Customer resIDs:</h3>
<% 
	String lineT = request.getParameter("lineT");
	String resDate = request.getParameter("resDate");
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
    Statement st = con.createStatement();
    ResultSet rs;
 	
 	
 	{
 		
 	con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
 	
 	st = con.createStatement();

 	rs = st.executeQuery("Select * from takesFrom a, Schedule b, Reservation c " + "where a.ResID = c.ResID and a.Schedule_rowNum = b.rowNum and b.date = c.date and c.date = \""
			+ resDate + "\";");
 	while (rs.next()) {
 		out.print("<tr>");
		out.print("<td>");
		out.print(rs.getString("resID"));
		out.print("</td>");
		out.print("<td>");
		}
 	}
 	
	
	%>
	<form action="serviceRep.html">
		<button>Back to Home</button>
	</form>
	
