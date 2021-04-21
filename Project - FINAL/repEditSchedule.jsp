<%@ page import="java.sql.*" %>
<%
	int rowNum = Integer.parseInt(request.getParameter("rowNum"));
	int length = Integer.parseInt(request.getParameter("length"));
	int stops = Integer.parseInt(request.getParameter("stops"));
	String Line_lineName = request.getParameter("Line_lineName");
	String arrival = request.getParameter("arrival");
	String departure = request.getParameter("departure");
	String date = request.getParameter("date");


	
    
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from Schedule where rowNum='" + rowNum + "'");
    if(rs.next()){
    	st.executeUpdate("update Schedule set length='" + length +"' where rowNum ='" + rowNum + "'");
    	st.executeUpdate("update Schedule set stops='" + stops +"' where rowNum ='" + rowNum + "'");
    	st.executeUpdate("update Schedule set Line_lineName='" + Line_lineName +"' where rowNum='"+ rowNum + "'");
    	st.executeUpdate("update Schedule set arrival='" + arrival +"' where rowNum='"+ rowNum + "'");
    	st.executeUpdate("update Schedule set departure='" + departure +"' where rowNum='"+ rowNum + "'");
    	st.executeUpdate("update Schedule set date='" + date +"' where rowNum='"+ rowNum + "'");


    	
    	
    	out.println("<a href='serviceRep.html'>Return to home</a><br>");
    	
    	
    } else {
      
    	out.println("Invalid Reservation <a href='editTrainSchedule.jsp'> Try again</a>");
        
    }
%>

<%
	con.close();
    st.close();  		
	rs.close();
    
%>
