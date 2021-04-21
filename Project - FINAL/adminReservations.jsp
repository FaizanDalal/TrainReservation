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

//Full reservation information
ArrayList <Integer> makesResNum = new ArrayList <Integer> ();
ArrayList <String> resUN = new ArrayList <String>();
ArrayList <String> selectUN = new ArrayList <String>(); 
ArrayList <Integer> resNums = new ArrayList <Integer>();
ArrayList <String> resDates = new ArrayList <String> ();
ArrayList <Float> resTotalFares = new ArrayList <Float> ();

//Stop information for Transit Line requests
ArrayList <Integer> getStopsResNum = new ArrayList <Integer> ();
ArrayList <String> getStopsLN = new ArrayList <String> ();
ArrayList <String> selectLN = new ArrayList <String> ();
String lineNameReq = "";

//Reservation Origins
ArrayList <String> origins = new ArrayList <String> ();
ArrayList <String> destinations = new ArrayList <String> ();

//Specific reservation information
ArrayList <Integer> reqResNums = new ArrayList <Integer>();
ArrayList <String> reqResDates = new ArrayList <String> ();
ArrayList <Float> reqResTotalFares = new ArrayList <Float> ();
ArrayList <String> reqResOrigins = new ArrayList <String> ();
ArrayList <String> reqResDests = new ArrayList <String> ();
String usernameReq = "";

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


ResultSet reservationOrigins = st.executeQuery("SELECT g.resID, s.Name FROM Station s, getStops g WHERE g.fromSID = s.SID GROUP BY g.resid");

while (reservationOrigins.next())
{
	
	origins.add(reservationOrigins.getString("Name"));
	
}

reservationOrigins.close();

ResultSet reservationDestinations = st.executeQuery("SELECT g.resID, s.Name FROM Station s, getStops g WHERE g.toSID = s.SID GROUP BY g.resid");

while (reservationDestinations.next())
{
	
	destinations.add(reservationDestinations.getString("Name"));
	
}

reservationOrigins.close();


ResultSet makesSet = st.executeQuery("SELECT * FROM makes");

while (makesSet.next())
{
	
	makesResNum.add(Integer.parseInt(makesSet.getString("makeResID")));
	resUN.add(makesSet.getString("makeUN"));
	if(!selectUN.contains(makesSet.getString("makeUN")))
		selectUN.add(makesSet.getString("makeUN"));
	
}

if(request.getParameter("usernameSend") != null && request.getParameter("userSelect") != null)
	usernameReq = request.getParameter("userSelect");

if(request.getParameter("lineNameSend") != null && request.getParameter("lineSelect") != null)
	lineNameReq = request.getParameter("lineSelect");

makesSet.close();

ResultSet allReservations = st.executeQuery("SELECT * FROM Reservation");

while(allReservations.next())
{
	
	resNums.add(Integer.parseInt(allReservations.getString("resID")));
	resDates.add(allReservations.getString("date"));
	resTotalFares.add(Float.parseFloat(allReservations.getString("totalFare")));
	
}

allReservations.close();

ResultSet lineReservations = st.executeQuery("SELECT * FROM getStops");

while (lineReservations.next())
{
	
	getStopsResNum.add(Integer.parseInt(lineReservations.getString("resID")));
	getStopsLN.add(lineReservations.getString("lineName"));
	if(!selectLN.contains(lineReservations.getString("lineName")))
		selectLN.add(lineReservations.getString("lineName"));
	
}

lineReservations.close();

if(request.getParameter("usernameSend") != null && request.getParameter("userSelect") != null)
	for(int i=0; i<makesResNum.size(); i++)
	{
		
		if(resUN.get(i).equals(usernameReq))
		{
			
			reqResNums.add(resNums.get(i));
			reqResDates.add(resDates.get(i));
			reqResTotalFares.add(resTotalFares.get(i));
			reqResOrigins.add(origins.get(i));
			reqResDests.add(destinations.get(i));
		}
		
	}


else if(request.getParameter("lineNameSend") != null && request.getParameter("lineSelect") != null)
	for(int i=0; i<getStopsLN.size(); i++)
	{
		
		if(getStopsLN.get(i).equals(lineNameReq))
		{
			int j=0;
			while(!resNums.get(j).equals(getStopsResNum.get((i))))
				j++;
			
			reqResNums.add(resNums.get(j));
			reqResDates.add(resDates.get(j));
			reqResTotalFares.add(resTotalFares.get(j));
			reqResOrigins.add(origins.get(i));
			reqResDests.add(destinations.get(i));
			
		}
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
  		
  		<a href="admin.jsp">Home</a>
  		<a href="adminCustRep.jsp">Customer Representative Tools</a>
 		<a href="adminSalesReports.jsp">Sales Reports</a>
		<a class="active" href="adminReservations.jsp">Reservation Information</a>
		<a href="adminRevenue.jsp">Revenue Information</a>
		<a href="logout.jsp">Logout</a>
		
		
		</div>
		
		<div class="backgroundPhoto res"><br><br>
			
			<%
			
			if(request.getParameter("usernameSend") != null && request.getParameter("userSelect") != null)
				{
					out.println("<div class = \"adminWorkWindow sr\"><u>Reservation Report For " + usernameReq + "</u>" + 
							    "<br><br><table class=\"adminTable\" border=\"1\"> <tr> <th> Number </th> <th> Date </th> <th> Origin </th> <th> Destination </th> <th> Total Cost </th> </tr>");
				
					for(int i = 0; i<reqResNums.size(); i++)
						out.println("<tr> <td>" + reqResNums.get(i).toString() + "</td> <td>" + reqResDates.get(i).toString() + 
								"</td> <td>" + origins.get(i).toString() + "</td><td>" + destinations.get(i).toString() + "</td><td>" 
								+ "$" + String.format("%.02f", reqResTotalFares.get(i)) + "</td></tr>");
					
					out.println("</table><br><br></div>");					
				}
			
			
			if(request.getParameter("lineNameSend") != null && request.getParameter("lineSelect") != null)
			{
			
				out.println("<div class = \"adminWorkWindow sr\"><u>Reservation Report For " + lineNameReq + "</u>" + 
						    "<br><br><table class=\"adminTable\" border=\"1\"> <tr> <th> Number </th> <th> Date </th> <th> Origin </th> <th> Destination </th> <th> Total Cost </th> </tr>");
				
				for(int i = 0; i<reqResNums.size(); i++)
					out.println("<tr> <td>" + reqResNums.get(i).toString() + "</td> <td>" + reqResDates.get(i).toString() + 
							"</td> <td>" + origins.get(i).toString() + "</td><td>" + destinations.get(i).toString() + "</td><td>" 
							+ "$" + String.format("%.02f", reqResTotalFares.get(i)) + "</td></tr>");
					
				out.println("</table><br><br></div>");					
			
				
			}

				
			%>			
						
			<div class = "infoWindow sales"> <u>Reservations By User</u><br><br>
				
				<form method = "post" action= adminReservations.jsp>
					<select name = "userSelect" size =<%out.println("\"" + selectUN.size() + "\"");%>>
						
						<%
						
							for(int i=0; i<selectUN.size(); i++)
							{
								out.println("<option value=\"" + selectUN.get(i) + "\">" + selectUN.get(i) + "</option>");
									
							}
					
						%>

				
					</select><br><br>
								
					<button name="usernameSend" type="Submit" value = "usernameSend"> Get Reservations </button>
				
				</form>

				<br><br>
				
				<u>Reservations By Transit Line</u><br><br>
				
				<form method = "post" action= adminReservations.jsp>
					<select name = "lineSelect" size =<%out.println("\"" + selectLN.size() + "\"");%>>
						
						<%
						
							for(int i=0; i<selectLN.size(); i++)
							{
								out.println("<option value=\"" + selectLN.get(i) + "\">" + selectLN.get(i) + "</option>");
									
							}
					
						%>

				
					</select><br><br>
								
					<button name="lineNameSend" type="Submit" value = "lineNameSend"> Get Reservations </button><br><br>
				
				</form>
			
		
			
		
		 	</div>
		 	
		 	
		 	

		 
		 
		 
		 </div>		
		
		

				
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>