<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

	
	<%
	try {
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	    Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
	    Statement st = con.createStatement();
	    ResultSet rs;	
		String fName = request.getParameter("fName");
		String lName = request.getParameter("lName");
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String usernameQuery = "SELECT username from Customer WHERE username='" + username + "'";
		ResultSet checkUsername = st.executeQuery(usernameQuery);
		if(checkUsername.next()) {
            out.println("The requested username already exists.");
            out.println("<br> <a href='createAccount.html'>Return to account creation page</a>");
		}
		
		String query = "INSERT INTO Customer(username, password, fName, lName, email)  VALUES (\'" + 
        	    username + "\', \'" + password + "\', \'" + 
        	    fName + "\', \'" + lName + "\', \'" + email + "\');";
		
       	st.executeUpdate(query);
		
		con.close();
    	out.println("<p>Account Created!</p><button onclick=\"window.location.href='index.html';\">Log In</button>");
	} catch (Exception e) {
		out.print(e);
		out.print("Error creating account");
		
	}
	
	
	%>
