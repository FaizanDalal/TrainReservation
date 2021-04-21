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


ResultSet salesSet = st.executeQuery("SELECT * FROM Reservation");






int reqYear = 0;

if(request.getParameter("sendYear") != null && request.getParameter("yearSelect") != null)
	reqYear = Integer.parseInt(request.getParameter("yearSelect"));

ArrayList <Integer> Year = new ArrayList <Integer>();
ArrayList <String> Month = new ArrayList <String>();
ArrayList <Float> Total = new ArrayList <Float>();
ArrayList <Integer> Reservations = new ArrayList <Integer>();

String [] Months = {"Janurary", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November","December"};

int currentYear = 0;
int currentMonth = 0;
float monthlyTotal = 0;
int monthlyRes = 0;
int currMonth = -1;
int testMonth = 0;

while (salesSet.next())
{
	Integer ticketYear = Integer.parseInt(salesSet.getString("date").toString().split("-")[0]);
	
	if(!Year.contains(ticketYear))
	{
		Year.add(ticketYear);
		for(int i=0; i<Months.length; i++)
		{
			Month.add(Months[i]);
			Total.add(0f);
			Reservations.add(0);
			
		}
	}
}

salesSet.beforeFirst();

while (salesSet.next())
{
	int ticketYear = Integer.parseInt(salesSet.getString("date").toString().split("-")[0]);
	int ticketMonth = (Integer.parseInt(salesSet.getString("date").toString().split("-")[1]) -1 );
	int yearCounter = 0;
	
	while(Year.get(yearCounter) != ticketYear)
	{
		yearCounter++;		
	}
	
	yearCounter *= 12;
	
	Total.set(yearCounter+ticketMonth, (Total.get(yearCounter+ticketMonth) + Float.parseFloat(salesSet.getString("totalFare"))));
	Reservations.set(yearCounter+ticketMonth, (Reservations.get(yearCounter+ticketMonth) + 1));

}

int yearCounter = 0;


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
 		<a class="active" href="adminSalesReports.jsp">Sales Reports</a>
		<a href="adminReservations.jsp">Reservation Information</a>
		<a href="adminRevenue.jsp">Revenue Information</a>
		<a href="logout.jsp">Logout</a>
		
		</div>
		
		<div class="backgroundPhoto sr"><br><br>
			
			<%
			
				if(request.getParameter("sendYear") != null && request.getParameter("yearSelect") != null)
				{
					out.println("<div class = \"adminWorkWindow sr\"><br><u>Sales Report For " + reqYear + "</u>" + 
							    "<br><br><table class=\"adminTable\" border=\"1\"> <tr> <th> Month </th> <th> Total Revenue </th> <th> Total Reservations </th> </tr>");
								
					yearCounter *= 0;
					
					while(Year.get(yearCounter) != reqYear)
						yearCounter++;
					
					yearCounter *= 12;
					
					for(int i = 0; i<12; i++)
						out.println("<tr> <td>" + Month.get(yearCounter+i).toString() + "</td> <td> $" + String.format("%.02f",Total.get(yearCounter+i)) + 
									"</td> <td>" + Reservations.get(yearCounter+i).toString() + "</td></tr>");
					
					out.println("</table><br><br></div>");
					
				}
				
			%>
			
			<table></table>
			
			<div class = "infoWindow sales"> <br> <u>Sales Reports</u><br><br>
				
				<form method = "post" action= adminSalesReports.jsp>
					<select name = "yearSelect" size =<%out.println("\"" + Year.size() + "\"");%>>
						
						<%
						
							for(int i=0; i<Year.size(); i++)
							{
								out.println("<option value=\"" + Year.get(i) + "\">" + Year.get(i) + "</option>");
									
							}
					
						%>

				
					</select><br><br>
								
					<button name="sendYear" type="Submit" value = "sendYear"> Get Report </button>
				
				</form>
				<br>
		
		 	</div>
		 
		 
		 
		 </div>	
		
				
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>