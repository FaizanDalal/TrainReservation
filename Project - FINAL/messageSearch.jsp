<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Search Results</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
	<%
	
			String searchTopic = request.getParameter("searchTopic");
			String searchUser = (String)session.getAttribute("user");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		    Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
		    Statement st = con.createStatement();
		    Statement st2 = con.createStatement();
		    
		    String query = "SELECT * from Messages where username = '" + searchUser + "' AND topic LIKE \'%" + searchTopic + "%\'";
			ResultSet rs = st.executeQuery(query);
			
			if(!rs.next())
			{
				out.println("<p>No messages match your query.</p>");
			}
			
			else
			{
				rs.beforeFirst();
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
					String displayMessage = "";
					if (a == null || rep == null) {
						displayMessage = "Topic: " + t + "<br>Message: " + m + "<br>Response: No response.";
					} else {
						displayMessage = "Topic: " + t + "<br>Message: " + m + "<br>Response: " + rep + "<br>Rep: " + a;
					}
					
					out.print("<p>" + displayMessage + "</p>");
					name.close();
				}
			}
			
			st.close();
			st2.close();
			rs.close();
		
	%>
	<form action="messaging.jsp">
		<button>Back to Messages</button>
	</form>
</body>
</html>