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



ResultSet stationSet = st.executeQuery("SELECT * From Station");

int reqYear = 0;
int reqMonth = 0;
int reqDay = 0;
int rowCount = 0;
int totalRows = 0;
int stationCount = 0;

if(request.getParameter("sendYear") != null)
{
	if((request.getParameter("yearSelect") != null) && (request.getParameter("monthSelect") != null) && (request.getParameter("daySelect") != null))
	{
		reqYear = Integer.parseInt(request.getParameter("yearSelect"));
		reqMonth = Integer.parseInt(request.getParameter("monthSelect"));
		reqDay = Integer.parseInt(request.getParameter("daySelect"));
	}
}

ArrayList <Integer> scheduleYear = new ArrayList <Integer>();
ArrayList <Integer> scheduleMonth = new ArrayList <Integer>();
ArrayList <Integer> scheduleDay = new ArrayList <Integer>();
ArrayList <Integer> Year = new ArrayList <Integer>();
ArrayList <Integer> Month = new ArrayList <Integer>();
ArrayList <Integer> Day = new ArrayList <Integer>();
ArrayList <String> aHour = new ArrayList <String>();
ArrayList <String> aMinute = new ArrayList <String>();
ArrayList <String> aSecond = new ArrayList <String>();
ArrayList <String> dHour = new ArrayList <String>();
ArrayList <String> dMinute = new ArrayList <String>();
ArrayList <String> dSecond = new ArrayList <String>();
ArrayList <String> aStation = new ArrayList <String>();
ArrayList <String> dStation = new ArrayList <String>();
ArrayList <String> nameStation = new ArrayList <String>();
ArrayList <String> idStation = new ArrayList <String>();
ArrayList <String> lineName = new ArrayList <String>();
ArrayList <String> stopLine = new ArrayList <String>();
ArrayList <Float> Fare = new ArrayList <Float>();
ArrayList <String> line = new ArrayList <String>();
ArrayList <String> tbStops = new ArrayList <String>();

while (stationSet.next()){
	if(!nameStation.add(stationSet.getString("Name").toString())){
		nameStation.add(stationSet.getString("Name").toString());
		stationCount++;
	}
	if(!idStation.add(stationSet.getString("SID").toString())){
		idStation.add(stationSet.getString("SID").toString());
	}
}
stationSet.close();

ResultSet stopSet = st.executeQuery("SELECT * FROM haveStops");
int q = 0;
while(stopSet.next()){
	q++;
	String ticketAStation = stopSet.getString("toSID").toString();
	String ticketDStation = stopSet.getString("fromSID").toString();
	String ticketStopLine = stopSet.getString("lineName").toString();
	String ticketTBStops = stopSet.getString("timeBetweenStops").toString();
	
	if(!aStation.add(ticketAStation)){
		aStation.add(ticketAStation);
	}
	if(!dStation.add(ticketDStation)){
		dStation.add(ticketDStation);
	}
	if(!stopLine.add(ticketStopLine)){
		stopLine.add(ticketStopLine);
	}
	if(!tbStops.add(ticketTBStops)){
		tbStops.add(ticketTBStops);
	}
}
stopSet.close();
ResultSet scheSet = st.executeQuery("SELECT * FROM Schedule"); //find way to link schedule, tid, arrival/ departur stations

while (scheSet.next()) //need a way to distinguish size
{
	rowCount++;

	Integer ticketYear = Integer.parseInt(scheSet.getString("date").toString().split("-")[0]);
	Integer ticketMonth = Integer.parseInt(scheSet.getString("date").toString().split("-")[1]);
	Integer ticketDay = Integer.parseInt(scheSet.getString("date").toString().split("-")[2]);
	String ticketAHour = (scheSet.getString("arrival").toString().split(":")[0]);
	String ticketAMin = (scheSet.getString("arrival").toString().split(":")[1]);
	String ticketASec = (scheSet.getString("arrival").toString().split(":")[2]);
	String ticketDHour = (scheSet.getString("departure").toString().split(":")[0]);
	String ticketDMin = (scheSet.getString("departure").toString().split(":")[1]);
	String ticketDSec = (scheSet.getString("departure").toString().split(":")[2]);
	
	String ticketLineName = scheSet.getString("Line_lineName").toString();
	
	if(!Year.contains(ticketYear))
	{
		Year.add(ticketYear);
	}
	if(!Month.contains(ticketMonth))
	{
		Month.add(ticketMonth);
	}
	if(!Day.contains(ticketDay))
	{
		Day.add(ticketDay);
	}
	if(!scheduleYear.add(ticketYear))
	{
		scheduleYear.add(ticketYear);
	}
	if(!scheduleMonth.add(ticketMonth))
	{
		scheduleMonth.add(ticketMonth);
	}
	if(!scheduleDay.add(ticketDay))
	{
		scheduleDay.add(ticketDay);
	}
	if(!aHour.add(ticketAHour)){
		aHour.add(ticketAHour);
	}
	if(!aMinute.add(ticketAMin)){
		aMinute.add(ticketAMin);
	}
	if(!aSecond.add(ticketASec)){
		aSecond.add(ticketASec);
	}
	if(!dHour.add(ticketDHour)){
		dHour.add(ticketDHour);
	}
	if(!dMinute.add(ticketDMin)){
		dMinute.add(ticketDMin);
	}
	if(!dSecond.add(ticketDSec)){
		dSecond.add(ticketDSec);
	}
	if(!lineName.add(ticketLineName)){
		lineName.add(ticketLineName);
	}
	totalRows = rowCount;
}

String placeHold = null;
for(int j = 0; j < totalRows; j++){
	for(int k = 0; k < stationCount; k++){
		if(idStation.get(k) == aStation.get(j)){
			aStation.set(j,nameStation.get(k));
		}
		if(idStation.get(k) == dStation.get(j)){
			dStation.set(j,nameStation.get(k));
		}
	}
}


scheSet.close();
ResultSet lineSet = st.executeQuery("SELECT * FROM Line");
int lineCount = 0;
while(lineSet.next()){
	lineCount++;
	String ticketLine = lineSet.getString("lineName");
	Float ticketFare = Float.parseFloat(lineSet.getString("Fare"));
	
	if(!Fare.add(ticketFare)){
		Fare.add(ticketFare);
	}
	if(!line.add(ticketLine)){
		line.add(ticketLine);
	}
}
rowCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./style/style.css">
<title>SpeedyTransit</title>

</head>

<body>

<div class="SpeedyLogo"></div>

<div class="navbar">

  		<a href="customer.html">Home</a>
 		<a href="reservation.jsp">Reservations</a>
		<a class="active" href="schedule.jsp">Train Schedules</a>
		<a href="contact.jsp">Contact Us</a>
		<a href="logout.jsp">Logout</a>
</div>
<div class="backgroundPhoto sch">		
<%

if(request.getParameter("sendDate") != null)
{
	if((request.getParameter("yearSelect") != null) && (request.getParameter("monthSelect") != null) && (request.getParameter("daySelect") != null)){
		reqYear = Integer.parseInt(request.getParameter("yearSelect"));
		reqMonth = Integer.parseInt(request.getParameter("monthSelect"));
		reqDay = Integer.parseInt(request.getParameter("daySelect"));
		out.println("<br><div class = \"workWindow sch\"><br><u><strong>Train Schedule for " + reqMonth + "/" + reqDay + "/" + reqYear + "  (MM/DD/YYYY)" + "</strong></u>" + 
			    "<br><br><table class=\"center\" border=\"1\" width = \"70%\" > <tr> <th> Arrival Time (HH:MM:SS)</th> <th> Departure Time (HH:MM:SS)</th> <th> Running Lines </th> <th> Fare </th> </tr>");
		//WIP
		
		for(int i = 0; i < totalRows; i++){
			
			int dayHold = Integer.parseInt(request.getParameter("daySelect"));
			if(scheduleDay.get(i) == reqDay && scheduleYear.get(i) == reqYear && scheduleMonth.get(i) == reqMonth){
				
				float baseFare = 0;
				if(lineName.get(i).equals("East")){
					for(int j = 0; j < lineCount; j++){
						if(line.get(j).equals("East")){
							baseFare = Fare.get(j);
						}
					}
				}else if(lineName.get(i).equals("North")){
					for(int j = 0; j < lineCount; j++){
						if(line.get(j).equals("North")){
							baseFare = Fare.get(j);
						}
					}
				}else if(lineName.get(i).equals("South")){
					for(int j = 0; j < lineCount; j++){
						if(line.get(j).equals("South")){
							baseFare = Fare.get(j);
						}
					}
				}else if(lineName.get(i).equals("Shore")){
					for(int j = 0; j < lineCount; j++){
						if(line.get(j).equals("Shore")){
							baseFare = Fare.get(j);
						}
					}
				}else if(lineName.get(i).equals("West")){
					for(int j = 0; j < lineCount; j++){
						if(line.get(j).equals("West")){
							baseFare = Fare.get(j);
						}
					}
				}else{
					break;
				}
				out.println("<tr> <td>" + aHour.get(i) + ":" + aMinute.get(i) + ":" + aSecond.get(i) +"</td> <td>" + 
				dHour.get(i) + ":" + dMinute.get(i) + ":" + dSecond.get(i) +"</td> <td>"+ lineName.get(i) +"</td> <td>$"+ baseFare +"</td> </tr>");
			}
		}
		
		out.println("</table><br><br></div>");
	}else{
		
		out.println("Make sure to choose a MONTH, DAY and YEAR before submitting.");
		
	}
}

%>
<div class = "workWindow sch"><br><br>
	<strong>Stops in Each Line</strong>
	<br><br>
	<table class="center" border="1" width = "70%" >
	<tr> <th> Line Name</th> <th> Starting Station </th> <th> Ending Station </th> <th> Time Between Stops </th> </tr>
	<%
		for(int i = 0; i < q; i++){
			out.println("<tr><td>"+ stopLine.get(i) +"</td><td>"+ dStation.get(i) +"</td><td>"+ aStation.get(i) +"</td><td>"+ tbStops.get(i) +"</td></tr>");
		}
	%>
	</table>
	
</div><!-- stops in each line -->
<div class = "infoWindow sch"> <!-- Schedule Search Info  --> <br>
	<strong>Schedule Credentials</strong><br><br>		
	<form method = "post" action= schedule.jsp>
		<label for = "yearSelect">Year:  </label>
		<select name = "yearSelect" size =<%out.println("\"" + Year.size() + "\"");%>>
				
			<%
			
				for(int i=0; i<Year.size(); i++)
				{
					out.println("<option value=\"" + Year.get(i) + "\">" + Year.get(i) + "</option>");
						
				}
		
			%>

		
		</select>
		<br><br>
		<label for = "monthSelect">Month:  </label>
		<select name = "monthSelect" size =<%out.println("\"" + Month.size() + "\"");%>>
				
			<%
			
				for(int i=0; i<Month.size(); i++)
				{
					out.println("<option value=\"" + Month.get(i) + "\">" + Month.get(i) + "</option>");
						
				}
		
			%>

		
		</select>
		<br><br>
		<label for = "daySelect">Day:  </label>
		<select name = "daySelect" size =<%out.println("\"" + Day.size() + "\"");%>>
				
			<%
			
				for(int i=0; i<Day.size(); i++)
				{
					out.println("<option value=\"" + Day.get(i) + "\">" + Day.get(i) + "</option>");
						
				}
		
			%>

		
		</select>
		<br><br>
							
		<button name="sendDate" type="Submit" value = "sendDate"> View Schedule </button><br><br>
			
	</form>
			
		
</div>

		
</div> 
				
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>
		
