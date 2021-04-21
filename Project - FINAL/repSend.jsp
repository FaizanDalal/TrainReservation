<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Reply Sent</title>
	<link rel="stylesheet" href="style.css">
</head> 
<body>
	<%
			
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
    		Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
		    Statement st = con.createStatement();
		    Statement st2 = con.createStatement();
		    
		    try
		    {
		    	int ID = Integer.parseInt(request.getParameter("ID"));
				String newReply = request.getParameter("reply");
				String userN = (String)session.getAttribute("user");
		    	String query = "UPDATE Messages SET reply=\"" + newReply + "\", RepUser=\'" + userN + "\' WHERE ID= " + ID + ";";
			    st.executeUpdate(query);
			    out.println("<h3>Sent!</h3>");
		    }
		    catch (Exception e)
		    {
		    	out.println("No messages found.");
		    }
		    st.close();
		    st2.close();
	    	con.close();
	
		
		
	%>
	<form action="serviceRep.html" method="post">
    	<button>Return home</button>
    </form>
</body>
</html>