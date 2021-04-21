<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Past Messages</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
<%
	
			String viewMessages = request.getParameter("viewMessages");
			String userN = (String)session.getAttribute("user");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		    Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
			Statement st = con.createStatement();
			Statement st2 = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * from Messages where username=\'" + userN + "\'");
			while (rs.next()) {
				String u = rs.getString("username");
				String t = rs.getString("topic");
				String m = rs.getString("message");
				String repUser = rs.getString("RepUser");
				String a = "";
				ResultSet name = st2.executeQuery("SELECT username from ServiceRep WHERE username=\'" + repUser + "\';");
				if (name.next()) {
					a = name.getString("username");
				}
				String rep = rs.getString("reply");
				String display = "";
				if (a != null || rep != null) {
					display = "Topic: " + t + "<br>Message: " + m + "<br>Response: " + rep + "<br>Rep: " + a;

			} else {
					display = "Topic: " + t + "<br>Message: " + m + "<br>Response: No response.";
				}
				out.print("<p>" + display + "</p>");
				name.close();
			}
			st.close();
			st2.close();
			rs.close();
			con.close();
			%>
		<form action="messaging.jsp">
		<button>Back to Messages</button>
	</form>
</body>
</html>
		    