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


ArrayList <String> userNames = new ArrayList <String>();

ArrayList <String> lineNames = new ArrayList <String> ();
ArrayList <Float> lineTotals = new ArrayList <Float>();
ArrayList <Integer> lineTotalRes = new ArrayList <Integer>();


ArrayList <String> fullNames = new ArrayList <String> ();
ArrayList <Float> userTotals = new ArrayList <Float>();
ArrayList <Integer> userTotalRes = new ArrayList <Integer>();

String bestCustomer = "";
float bestCustTotal = 0.2f;

ArrayList <String> tempLines = new ArrayList <String>();
ArrayList <Float> tempTotals = new ArrayList <Float>();

ArrayList <String> bestFiveLines = new ArrayList <String>();
ArrayList <Float> bestFiveTotals = new ArrayList <Float>();

String bestLine = "";
float bestLineTotal = 0.2f;

ResultSet customers = st.executeQuery("SELECT * FROM Customer;");

while (customers.next())
{
	
	userNames.add(customers.getString("userName"));
	
}

customers.close();

ResultSet lines = st.executeQuery("SELECT * FROM Line;");

while (lines.next())
{
	
	lineNames.add(lines.getString("lineName"));
	
}

lines.close();



for(int i=0; i<userNames.size(); i++)
{
	
	ResultSet byUser = st.executeQuery("SELECT c.fName, c.lName, sum(r.totalFare) sumTotFare, count(r.totalFare) countTotFare FROM Reservation r, makes m, Customer c " +
			   "WHERE r.resID = m.makeResID AND c.username = m.makeUN AND	  m.makeUN = \"" + userNames.get(i) + "\"");
	
	byUser.next();
	
	fullNames.add(byUser.getString("fName") + " " + byUser.getString("lName"));
	userTotals.add(byUser.getFloat("sumTotFare"));
	userTotalRes.add(byUser.getInt("countTotFare"));
	
	byUser.close();
}


for(int i=0; i<lineNames.size(); i++)
{
	
	ResultSet byLine = st.executeQuery("SELECT g.lineName, count(g.resID) resCount, sum(r.totalFare) totalFares" + 
										" FROM getStops g, Reservation r WHERE g.resID = r.resID AND  g.lineName = \"" + lineNames.get(i) + "\"");
	
	byLine.next();
	
	lineTotals.add(byLine.getFloat("totalFares"));
	lineTotalRes.add(byLine.getInt("resCount"));
	
	byLine.close();
	
	
	
}

bestCustomer = userNames.get(0);
bestCustTotal = userTotals.get(0);

for(int i=1; i<userTotals.size(); i++)
{
	
	if(userTotals.get(i) > bestCustTotal)
	{
		bestCustomer = fullNames.get(i);
		bestCustTotal = userTotals.get(i);
	}
	
}

for(int i=0; i<lineNames.size(); i++)
{
	
	tempLines.add(lineNames.get(i));
	tempTotals.add(lineTotals.get(i));
	
}

for(int i=0; i<5; i++)
{
	int indexWatcher = 0;
	bestLine = tempLines.get(0);
	bestLineTotal = tempTotals.get(0);
	
	for(int j=0; j<tempTotals.size(); j++)
	{
		
		if(tempTotals.get(j) > bestLineTotal)
		{
			bestLine = tempLines.get(j);
			bestLineTotal = tempTotals.get(j);
			indexWatcher = j;
		}
	
	}
	
	bestFiveLines.add(tempLines.get(indexWatcher));
	bestFiveTotals.add(tempTotals.get(indexWatcher));
	tempLines.remove(indexWatcher);
	tempTotals.remove(indexWatcher);

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
		<a href="adminReservations.jsp">Reservation Information</a>
		<a class="active"  href="adminRevenue.jsp">Revenue Information</a>
		<a href="logout.jsp">Logout</a>
		
		
		</div>
		
		<div class="backgroundPhoto rev"><br><br>
			
			<%
			
				out.println("<div class = \"adminWorkWindow rr\"><u>Revenue Report By Customer</u> <br><br><table class=\"adminTable\" border=\"1\"> <tr>" + 
							    "<th> Username </th> <th> Full Name </th> <th> Total </th> <th> Total Reservations </th> </tr>");
				
			for(int i = 0; i<userNames.size(); i++)
				out.println("<tr> <td>" + userNames.get(i).toString() + "</td> <td>" + fullNames.get(i).toString() + 
							"</td> <td> $" + String.format("%.02f",userTotals.get(i)) + "</td><td>" + userTotalRes.get(i).toString() + "</td></tr>");
					
				out.println("</table><br><br></div><br><br>");
					
				
			
			
				out.println("<div class = \"adminWorkWindow rr\"><u>Revenue Report By Transit Line</u> <br><br><table class=\"adminTable\" border=\"1\"> <tr>" + 
					    "<th> Line </th> <th> Total</th> <th> Total Reservations </th> </tr>");
		
				for(int i = 0; i<lineNames.size(); i++)
					out.println("<tr> <td>" + lineNames.get(i).toString() + "</td> <td> $" + String.format("%.02f",lineTotals.get(i)) + 
							    "</td><td>"  + lineTotalRes.get(i).toString() + "</td></tr>");
					
				out.println("</table><br><br></div><br>");
				
				out.println("<br><br>");
				
				out.println("<div class = \"adminWorkWindow bl\"><u>Best Five Lines</u><br><br><div class = \"adminWorkWindow bestInset\">" + 
							"<br><table class=\"adminTable\" border=\"1\">");
				
				for(int i = 0; i<bestFiveLines.size(); i++)
					out.println("<tr> <td>" + bestFiveLines.get(i).toString() + "</td></tr>");
				
				out.println("</table><br></div><br><br></div>");
				
				out.println("<div class = \"adminWorkWindow bc\"><u>Best Customer</u><br><br><div class = \"adminWorkWindow bestInset\">" + bestCustomer + "</div></div>");

				
				
				
								
				
			%>
			
			
		</div>				
<br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>