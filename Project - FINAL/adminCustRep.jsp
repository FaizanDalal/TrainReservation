<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.util.Collections"%>
<%@ page import ="java.util.Iterator"%>
<%@ page import ="java.util.*"%>


<%

String repSocial = "";
String repUserName = "";
String repFName = "";
String repLName = "";
String repPassword = "";
String fName="";

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");

Statement st = con.createStatement();

try{
	
	ResultSet firstName = st.executeQuery("SELECT e.fName FROM Employee e, Admin a WHERE e.SSN = a.SSN AND a.userName = \"" + session.getAttribute("user").toString() + "\";");
	
	firstName.next();
	fName = firstName.getString("fName");
   
	firstName.close();
	}

catch (Exception e){
	
	out.println("<meta http-equiv = 'refresh' content = '2; url = redirect.html' />");

	
	}

if(request.getParameter("getInfo") != null && request.getParameter("sRepInfo") != null)
	
	repSocial = request.getParameter("sRepInfo");

else if (request.getParameter("create") != null)
{
	repSocial =  request.getParameter("social");
	repUserName = request.getParameter("uName");
	repPassword = request.getParameter("uPassword");
	repFName = request.getParameter("fName");
	repLName = request.getParameter("lName");
		
}

else if (request.getParameter("delete") != null)
{
	repSocial =  request.getParameter("social");
		
}

else if (request.getParameter("update") != null)
{
	repSocial =  request.getParameter("social");
	repUserName = request.getParameter("uName");
	repFName = request.getParameter("fName");
	repLName = request.getParameter("lName");
	repPassword = request.getParameter("uPassword"); 
			
}



if (request.getParameter("delete") != null)
{
	
	st.executeUpdate("DELETE FROM ServiceRep where (`SSN` = '" + repSocial + "');");
	st.executeUpdate("DELETE FROM Employee where (`SSN` = '" + repSocial + "');");
	
}

else if (request.getParameter("create") != null)
{
	
	try{
		st.executeUpdate("INSERT INTO Employee (SSN, fName, lName) VALUES (\'" + repSocial + "\', \'" + repFName + "\', \'" + repLName + "\');");
		st.executeUpdate("INSERT INTO ServiceRep (SSN, username, password) VALUES (\'" + repSocial + "\', \'" + repUserName +"\', \'" + repPassword + "\');");
	}
	
	catch (Exception e){
		out.println("<p2>ERROR: Account could not be created! Make sure that the username and social have not been used already!</p2>");
	}
}

else if (request.getParameter("update") != null)
{
	
	ResultSet updateSet = st.executeQuery("SELECT * FROM ServiceRep WHERE SSN ='" + repSocial + "'");
	
	updateSet.next();

	String tempUserName = updateSet.getString("username");
	String tempPassword = updateSet.getString("password");
	
	updateSet.close();
	
	updateSet = st.executeQuery("SELECT * FROM Employee WHERE SSN ='" + repSocial + "'");
	
	updateSet.next();
	
	String tempFName = updateSet.getString("fname");
	String tempLName = updateSet.getString("lname");
	
	updateSet.close();
	
	int a;
	try{
	
		if(!tempUserName.equals(repUserName))
			a = st.executeUpdate("UPDATE ServiceRep SET username = '" + repUserName + "' WHERE SSN = '" + repSocial + "'");
	
		if(!tempPassword.equals(repPassword) && !repPassword.equals(""))
			a = st.executeUpdate("UPDATE ServiceRep SET password = '" + repPassword + "' WHERE SSN = '" + repSocial + "'");
	
		if(!tempFName.equals(repFName))
			a = st.executeUpdate("UPDATE Employee SET fname = '" + repFName + "' WHERE SSN = '" + repSocial + "'");
		
		if(!tempLName.equals(repLName))
			a = st.executeUpdate("UPDATE Employee SET lname = '" + repLName + "' WHERE SSN = '" + repSocial + "'");
	
	}
	
	catch (Exception e){
		out.println("<p2>ERROR: Account could not be updated! Make sure that the username has not been used already!</p2>");
	}
	
}

ResultSet srInfo = st.executeQuery("select * from ServiceRep");

ArrayList <String> ssn = new ArrayList<String>();
ArrayList <String> usernames = new ArrayList<String>();
ArrayList <String> fNames = new ArrayList<String>();
ArrayList <String> lNames = new ArrayList<String>();

while (srInfo.next()){
	
	ssn.add(srInfo.getString("SSN"));
	usernames.add(srInfo.getString("username"));
	
	if(request.getParameter("getInfo") != null)
	{
		if(repSocial.equals(srInfo.getString("SSN")))
			repUserName = srInfo.getString("username");
	}
	
}

srInfo.close();

ResultSet empInfo = st.executeQuery("select * from Employee e");

for(int i=0; i<ssn.size(); i++)
{
	while(empInfo.next())
		if(ssn.get(i).equals(empInfo.getString("SSN")))
		{
			fNames.add(empInfo.getString("fName"));
			lNames.add(empInfo.getString("lName"));
			
			if(request.getParameter("getInfo") != null)
			{
				if(repSocial.equals(empInfo.getString("SSN")))
				{
					repFName = empInfo.getString("fName");
					repLName = empInfo.getString("lName");
				}
			}
		}
	empInfo.beforeFirst();
}


empInfo.close();

con.close();

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

  		<a href="admin.jsp">Home</a>
  		<a class="active" href="adminCustRep.jsp">Customer Representative Tools</a>
 		<a href="adminSalesReports.jsp">Sales Reports</a>
		<a href="adminReservations.jsp">Reservation Information</a>
		<a href="adminRevenue.jsp">Revenue Information</a>
		<a href="logout.jsp">Logout</a>
		
		</div>
		
		<div class="backgroundPhoto ac">
			<br><br><br>
			
			
			<div class = "adminWorkWindow">
				<form method="post" action="adminCustRep.jsp"><br>
				  <label for="fname">First Name:</label><br>
				  <input type="text" id="fName" name="fName" value=<%if(request.getParameter("getInfo")!=null)out.print("\""+repFName+"\""); %>><br>
				  <label for="lName">Last Name:</label><br>
				  <input type="text" id="lName" name="lName" value=<%if(request.getParameter("getInfo")!=null)out.print("\""+repLName+"\""); %>><br>
				  <label for="social">Social:  </label><br>
				  <input type="text" id="social" name="social" value=<%if(request.getParameter("getInfo")!=null)out.print("\""+repSocial+"\" readonly"); %>><br>
				  <label for="uName">UserName:</label><br>
				  <input type="text" id="uName" name="uName" value=<%if(request.getParameter("getInfo")!=null)out.print("\""+repUserName+"\""); %>><br>
				  <label for="uPassword">Password:</label><br>
				  <input type="password" id="uPassword" name="uPassword" value=<%if(request.getParameter("getInfo")!=null)out.print("\""+repPassword+"\""); %>><br>
				  
				 
				  <%
				 
					if(request.getParameter("getInfo") == null)
						out.println("<br><button name = \"create\" type=\"Submit\" value = \"create\"> Create </button>");
					
					else if (request.getParameter("sRepInfo") != null)
					{
				 		out.println("<br><button name = \"update\" type=\"Submit\" value = \"Update\"> Update </button>");
				 		out.println("<button name = \"delete\" type=\"Submit\" value = \"Delete\"> Delete </button><br>");
				 		out.println("<br>Password only updates if something is entered!");
					}
				 %><br><br>
				 
				 </form><br><br>
				 

				 
			</div>
			
			
				
			<div class="infoWindow"><br>
				Current Service Representative Accounts			
				<form method = "post" action= adminCustRep.jsp>
				
				<select name = "sRepInfo" size =<%out.println("\"" + ssn.size() + "\"");%>>
					
					<%
						
						for(int i=0; i<ssn.size(); i++)
						{
							out.println("<option value=\"" + ssn.get(i) + "\">" + ssn.get(i) + " " + usernames.get(i) + "</option>");
							
						}
					
					%>

				
				</select><br>
							
				<button name="getInfo" type="Submit" value = "getInfo"> Get Info </button>
				
				</form>
				<br>

			</div>
	
		</div>
		

		

				
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>