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
Statement st = con.createStatement();

String fName="";

try{
	
	ResultSet firstName = st.executeQuery("SELECT e.fName FROM Employee e, Admin a WHERE e.SSN = a.SSN AND a.userName = \"" + session.getAttribute("user").toString() + "\";");
	
	firstName.next();
	fName = firstName.getString("fName");
   
	firstName.close();
	}

catch (Exception e){
	
	out.println("<meta http-equiv = 'refresh' content = '2; url = redirect.html' />");

	
	}

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./style/style.css">
<title>SpeedyTransit</title>


</head>

<body>
		<div class="SpeedyLogo admin"></div>
		<BR><%out.println("Welcome " + fName + "!"); %>
		
		<div class="navbar">
		
  		<a class="active" href="admin.jsp">Home</a>
  		<a href="adminCustRep.jsp">Customer Representative Tools</a>
 		<a href="adminSalesReports.jsp">Sales Reports</a>
		<a href="adminReservations.jsp">Reservation Information</a>
		<a href="adminRevenue.jsp">Revenue Information</a>
		<a href="logout.jsp">Logout</a>
		

		</div>
		
		<div class="backgroundPhoto ah"></div>
		
		

				
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>