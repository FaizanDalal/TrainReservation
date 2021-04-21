<%@ page import="java.sql.*" %>
<%
    String deletetrainschedule = request.getParameter("rowNum");
   
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from Schedule where rowNum='" + deletetrainschedule + "'");
    if(rs.next()){
    	
    	st.executeUpdate("delete from Schedule where rowNum='" + deletetrainschedule + "'");
  
    	out.println("The train schedule has been deleted. <a href='scheduleDelete.jsp'> Delete another one?</a> OR  ");
   
    	out.println("<a href='serviceRep.html'>Return home</a><br>");
    	
    	
    } else {
      
    	out.println("Invalid RowNum <a href='RepDelete.jsp'> Try Again</a>");
        
    }
%>

<%
	con.close();
    st.close();  		
	rs.close();
    
%>