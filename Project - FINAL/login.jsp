<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("userName");   
    String pwd = request.getParameter("passWord");
        
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://speedytransit.cdj2dtwyc7i8.us-east-1.rds.amazonaws.com:3306/SpeedyTransit","Group25", "SuperFool789");
    
    Statement st = con.createStatement();
    ResultSet rs;
    
    //Customer
    
    rs = st.executeQuery("select * from Customer where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("customer.html");
    } 
    
    rs = st.executeQuery("select * from ServiceRep where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("serviceRep.html");
    } 
    
    rs = st.executeQuery("select * from Admin where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("admin.jsp");
    } 

    else {
        
    	out.println("<meta http-equiv = 'refresh' content = '2; url = redirect.html' />");
    	
    }
    
%>