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

String y = null;
String m = null;
String d = null;

//Station 
ResultSet statSet = st.executeQuery("SELECT * FROM Station");
ArrayList <String> stats = new ArrayList <String>();
ArrayList <String> statsID = new ArrayList <String>();
ArrayList <String> statHolder = new ArrayList <String>();
while(statSet.next()){
	String statTicket = statSet.getString("Name");
	String statIDTicket = statSet.getString("SID");
	if(!stats.add(statTicket)){
		stats.add(statTicket);
	}
	if(!statsID.add(statIDTicket)){
		statsID.add(statIDTicket);
	}
}
statSet.close();

//EastRoute
ResultSet eastSet = st.executeQuery("SELECT fromSID, toSID FROM haveStops WHERE lineName = \"East\"");

ArrayList <String> routeEast = new ArrayList <String>();
ArrayList <String> fromEast = new ArrayList <String>();
ArrayList <String> toEast = new ArrayList <String>();
while(eastSet.next()){
	String fromTicket = eastSet.getString("fromSID");
	String toTicket = eastSet.getString("toSID");
	if(!fromEast.add(fromTicket)){
		fromEast.add(fromTicket);
	}
	if(!toEast.add(toTicket)){
		toEast.add(toTicket);
	}
}
eastSet.close();
for(int r = 0; r < fromEast.size(); r++){
	for(int e = 0; e < toEast.size(); e++){
		if(!toEast.contains(fromEast.get(e))){
			if(!routeEast.contains(fromEast.get(e))){
				routeEast.add(fromEast.get(e));
			};
			routeEast.add(toEast.get(e));
			fromEast.remove(e);
			//fromEast.remove(toEast.get(e));
			toEast.remove(e);
		}else if(fromEast.isEmpty() == true)
			break;
	}
	//out.println(routeEast.get(r));
}

ResultSet northSet = st.executeQuery("SELECT fromSID, toSID FROM haveStops WHERE lineName = \"North\"");
ArrayList <String> routeNorth = new ArrayList <String>();
ResultSet shoreSet = st.executeQuery("SELECT fromSID, toSID FROM haveStops WHERE lineName = \"Shore\"");
ResultSet southSet = st.executeQuery("SELECT fromSID, toSID FROM haveStops WHERE lineName = \"South\"");
ResultSet westSet = st.executeQuery("SELECT fromSID, toSID FROM haveStops WHERE lineName = \"West\"");

ResultSet routeSet = st.executeQuery("SELECT * FROM haveStops");
ArrayList <String> toID = new ArrayList <String>();
ArrayList <String> fromID = new ArrayList <String>();
ArrayList <String> toc = new ArrayList <String>();
ArrayList <String> fromc = new ArrayList <String>();
ArrayList <String> lineID = new ArrayList <String>();
while(routeSet.next()){
	String fromTicket = routeSet.getString("fromSID");
	String toTicket = routeSet.getString("toSID");
	String lineTicket = routeSet.getString("lineName");
	String fromcTicket = routeSet.getString("fromSID");
	String tocTicket = routeSet.getString("toSID");
	if(!toID.add(toTicket)){
		toID.add(toTicket);
	}
	if(!fromID.add(fromTicket)){
		fromID.add(fromTicket);
	}
	if(!lineID.add(lineTicket)){
		lineID.add(lineTicket);
	}
	if(!toc.contains(tocTicket)){
		toc.add(tocTicket);
	}
	if(!fromc.contains(fromcTicket)){
		fromc.add(fromcTicket);
	}
}
routeSet.close();

ResultSet scheduleSet = st.executeQuery("SELECT * FROM Schedule");

ArrayList <String> scheduleDate = new ArrayList <String>();
ArrayList <String> scheduleLine = new ArrayList <String>();
ArrayList <String> scheduleDepart = new ArrayList <String>();
ArrayList <String> departList = new ArrayList <String>();

int size = 0;
int schSize = 0;
while(scheduleSet.next()){
	size++;
	String ticketLines = scheduleSet.getString("Line_lineName").toString();
	String ticketDates = scheduleSet.getString("date").toString();
	String ticketDepart = scheduleSet.getString("departure").toString();
	if(!scheduleLine.add(ticketLines)){
		scheduleLine.add(ticketLines);
	}
	if(!scheduleDate.add(ticketDates)){
		scheduleDate.add(ticketDates);
	}
	if(!scheduleDepart.add(ticketDepart)){
		scheduleDepart.add(ticketDepart);
	}
	if(!departList.contains(ticketDepart)){
		departList.add(ticketDepart);
	}
	schSize = size;
}
//size = 0;
scheduleSet.close();

ArrayList <String> selectLines = new ArrayList <String>();



ResultSet lineSet = st.executeQuery("SELECT * FROM Line");

ArrayList <String> Lines = new ArrayList <String>();
ArrayList <Integer> Fares = new ArrayList <Integer>();

while(lineSet.next()){
	String ticketLines = lineSet.getString("lineName").toString();
	int ticketFares = Integer.parseInt(lineSet.getString("Fare").toString());
	if(!Lines.add(ticketLines)){
		Lines.add(ticketLines);
	}
	if(!Fares.add(ticketFares)){
		Fares.add(ticketFares);
	}
}
lineSet.close();
ResultSet reserveSet = st.executeQuery("SELECT * FROM Reservation r, makes, getStops g WHERE r.resID = makeResID AND r.resID = g.resID ");
reserveSet.beforeFirst();
String userName = (String) session.getAttribute("user");

//Make Reservations

int CountID = 0;
int sd = 0;
int cd = 0;
int dd = 0;
double calcFare = 0;
int regCost = 0;
double cdAmount = .25;
double sdAmount = .35;
double ddAmount = .5; //input later
int CountMyID = 0;
ArrayList <String> makeUNlocal = new ArrayList <String>();
ArrayList <String> Date = new ArrayList <String>();
ArrayList <String> allResID = new ArrayList <String>();
ArrayList <Float> allFare = new ArrayList <Float> ();
while(reserveSet.next()){
	String ticketMakeUN = reserveSet.getString("makeUN").toString();
	String ticketDate = reserveSet.getString("date").toString();
	String ticketReserve = reserveSet.getString("makeResID").toString();
	float ticketAllFare = Float.parseFloat(reserveSet.getString("totalFare").toString());
	if(!makeUNlocal.add(ticketMakeUN)){
		makeUNlocal.add(ticketMakeUN);
	}
	if(!Date.add(ticketDate)){
		Date.add(ticketDate);
	}
	if(!allResID.add(ticketReserve)){
		allResID.add(ticketReserve);
	}
	if(!allFare.add(ticketAllFare)){
		allFare.add(ticketAllFare);
	}
	CountID++;
	CountMyID++;
}
reserveSet.close();


if(request.getParameter("dataSend") != null){
	String inputDatestr = request.getParameter("uDate");
	String inputLinestr = request.getParameter("uLine");
	String DISCOUNT = request.getParameter("discount");
	String inputTimestr = request.getParameter("uDepart");
	String fromStat = request.getParameter("uStation");
	String toStat = request.getParameter("tStation");
	//testing
	//out.println(userName);
	//out.println(inputDatestr);
	//out.println(inputLinestr);
	//testing
	for(int w = 0; w < schSize; w++){	
		String tempDate = scheduleDate.get(w);
		if(tempDate == inputDatestr){
			selectLines.add(scheduleLine.get(w));
		}
	}
	
	if(!scheduleDate.contains(inputDatestr)){
		out.println("Select a Valid Date");
	//}else if(!selectLines.contains(inputLinestr)){
		//out.println("Select a Valid Line");
	}else if(inputTimestr == null){
		out.println("Select a Valid Departure Time");
	}else if(fromStat.equals(null)){
		out.println("Select a Valid Departure Station");
	}else if(toStat.equals(null)){
		out.println("Select a Valid Destination Station");
	}else if(DISCOUNT == null){
		out.println("Select a Valid Discount Option");
	}else{
		//SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		//Date inputDate = sdf.parse(inputDatestr);
		for (int x = 0; x < Fares.size(); x++){
			//out.println(Fares.get(x));
			if(Lines.get(x).equals(inputLinestr)){
				regCost = Fares.get(x);
			}
		}
		String ddstr = request.getParameter("dCount");
		String cdstr = request.getParameter("cDis");
		String sdstr = request.getParameter("sDis");
		String defdstr = request.getParameter("default");
		
		if(DISCOUNT.equals("1")){
			dd = 1;
		}else{
			dd = 0;
		}
		if(DISCOUNT.equals("2")){
			cd = 1;
		}else{
			cd = 0;
		}
		if(DISCOUNT.equals("3")){
			sd = 1;
		}else{
			sd = 0;
		}
		if(DISCOUNT.equals("4")){
			dd = 0;
			cd = 0;
			sd = 0;
		}
		out.println(regCost);
		out.println(dd);
		out.println(cd);
		out.println(sd);
		calcFare = regCost - ((((dd * ddAmount) * regCost) + (( cd * cdAmount) * regCost)) + (( sd * sdAmount) * regCost));
		out.println(calcFare);
		//out.println(inputLinestr);
		String upd = "INSERT INTO Reservation (resID, date, totalfare, seniorDiscount, childDiscount, disabledDiscount) VALUES(\'" + 
			CountID + "\', \'" + inputDatestr + "\', \'" + calcFare + "\', \'" + sd + "\', \'" + cd + "\', \'" + dd + "\');";
		st.executeUpdate(upd);
		String update = "INSERT INTO makes(makeUN,makeResID) VALUES(\'" + userName +"\',\'"+ CountID +"\');";
		st.executeUpdate(update);
		String date = "INSERT INTO getStops(resID,lineName,fromSID,toSID) VALUES(\'" + CountID +"\',\'"+ inputLinestr +"\',\'"+ fromStat +"\',\'"+ toStat +"\');";
		st.executeUpdate(date);
		
			
		CountID = 0;
	}
}

if(request.getParameter("dataRevoke") != null){
	
}


//All My Reservations/ Current and Past



ArrayList <String> resUN = new ArrayList <String>();
ArrayList <String> UserResDate = new ArrayList <String> ();
ArrayList <String> UserResNum = new ArrayList <String> ();
ArrayList <Float> tFare = new ArrayList <Float> ();
ArrayList <Float> cDiscount = new ArrayList <Float> ();
ArrayList <Float> sDiscount = new ArrayList <Float> ();
ArrayList <Float> nDiscount = new ArrayList <Float> ();

int i = 0; //temp count
int totalRes = 0; //Count of User Total Reservations
for(int w = 0; w < CountMyID; w++){
	String ticketURDate = Date.get(w);
	String ticketURID = allResID.get(w);
	float ticketURFare = allFare.get(w);
	if(userName.equals(makeUNlocal.get(w))){
		UserResDate.add(ticketURDate);
		UserResNum.add(ticketURID);
		tFare.add(ticketURFare);
		i++;
		totalRes = i;
	}

}

// Cancel Reservations





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
	 		<a class = "active" href="reservation.jsp">Reservations</a>
			<a href="schedule.jsp">Train Schedules</a>
			<a href="contact.jsp">Contact Us</a>
			<a href="logout.jsp">Logout</a>
		
		</div>
		
		<div class="backgroundPhoto rva"><br><br>
		
		<!-- Reservation Making -->
		<div class = "infoWindow res"> <!-- options for reservation --><br>
			<strong>Make a Reservation</strong>
			<form method = "post" action = reservation.jsp>
				<lable for = "uDate">Date of Reservation: </lable>
				<input type = "date" name = "uDate" id = "uDate" format = ><br><br>
				<lable for = "uLine">Line to Reserve</lable>
				<select name = "uLine" id = "uLine" size = <% out.println("\""+ Lines.size() +"\""); %>>
				<%
					for(int w = 0; w < Lines.size(); w++){
						out.println("<option value=\"" + Lines.get(w) + "\">" + Lines.get(w) + "</option>");
					}
				%>
				</select><br><br>
				<lable for = "uStation">Station to Depart From</lable>
				<select name = "uStation" size = <% out.println("\""+ fromc.size() +"\""); %>>
				<%
				for(int w = 0; w < fromc.size(); w++){
					out.println("<option value=\"" + fromc.get(w) + "\">" + fromc.get(w) + "</option>");
				}
				%>
				</select><br><br>
				<lable for = "tStation">Station to Depart To</lable>
				<select name = "tStation" size = <% out.println("\""+ toc.size() +"\""); %>>
				<%
				for(int w = 0; w < toc.size(); w++){
					out.println("<option value=\"" + toc.get(w) + "\">" + toc.get(w) + "</option>");
				}
				%>
				</select><br><br>
				<lable for = "uDepart">Time of Departure</lable>
				<select id = "uDepart" name = "uDepart" size = <% out.println("\""+ departList.size() +"\""); %>>
				<%
					for(int w = 0; w < departList.size(); w++){
						out.println("<option value=\"" + departList.get(w) + "\">" + departList.get(w) + "</option>");
					}
				%>
				</select><br><br>
				<lable for = "dCount"> Disabled Discount </lable>
				<input type = "radio" name = "discount" value = "1" id = "dCount"><br>
				<lable for = " cDis "> Child Discount </lable> 
				<input type = "radio" name = "discount" value = "2" id = "cDis"><br>
				<lable for = " sDis "> Senior Discount </lable>
				<input type = "radio" name = "discount" value = "3" id = "sDis"><br>
				<lable for = "default"> None </lable>
				<input type = "radio" name = "discount" value = "4" id = "default"><br><br>
				<button name ="dataSend" type = submit id = "dataSend">Make Reservation</button><br><br>
				<strong>Cancel a Reservation</strong><br><br>
				<lable for = "IDNum">Enter a Reservation ID Number:</lable>
				<input type = "text" id = "IDNum"><br><br>
				<button name ="dataRevoke" type = submit id = "dataRevoke">Cancel Reservation</button><br><br>
				<button name ="showRes" type = submit id = "showRes">Show Current and Past Reservations</button><br><br>
			</form>
		</div>	
		<!-- Table of User's Reservations -->
		
		<% 
			if(request.getParameter("showRes") != null){
				out.println("<div class = \"workWindow res\">" +
				"<strong>My Reservations</strong><br><br>" +
				"<table class = \"customerTable\" border = \"1\" align = \"center\">"+
				"<tr><th>Date of Reservation</th><th>Reservation Number</th><th>Total Fare</th></tr>");
			
				for(int j = 0; j < totalRes; j++){
					out.println("<tr><td>" + UserResDate.get(j) + "</td><td>" + UserResNum.get(j) + "</td><td>" + tFare.get(j) + "</td></tr>");
				}
				
				out.println("</table><br><br></div>");
			}
		%>
			

		</div>
<br><br>

<a href="https://pixabay.com/service/license/"> Image licensing information</a>	
</body>
</html>