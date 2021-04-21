<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Messaging Dash board</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
    
    <h3>Respond to Customers</h3>
    <form action="repSend.jsp" method="post">
        <h5>Message ID:</h5>
        <input name="ID" type="text">
        <h5>Response:</h5>
        <input name="reply" type="text"/>
        <br><br>
        <button>Send</button>
    </form>
    <form action="serviceRep.html">
    	<button>Back to Home</button>
    </form>
    <br>
    <h3>Unanswered Messages:</h3>
    <%
    	Class.forName("com.mysql.jdbc.Driver").newInstance();
    	Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * from Messages where RepUser IS NULL and reply IS NULL");
	    if(!rs.next())
	    {
	    	out.print("<p>There are no unanswered messages.</p>");
	    }
	    else
	    {
	    	while(rs.next())
		    {
		    	int id = rs.getInt("ID");
		    	String user = rs.getString("username");
		    	String topic = rs.getString("topic");
		    	String message = rs.getString("message");
		    	
		    	out.print("<p>" + id + "<br>" + user + "<br>" + topic + "<br>" + message + "</p>");
		    }
	    }
	    
	    st.close();
	    rs.close();
	    con.close();
    %>
   </body>
</html>