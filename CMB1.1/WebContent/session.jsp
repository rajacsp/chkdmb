<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*"
    pageEncoding="ISO-8859-1"%>
<%
String XYZ = (String) session.getAttribute("XYZ");	
if(XYZ != null){			
	response.sendRedirect("dashboard.jsp");
}

//might have come from login.jsp
String username = request.getParameter("username");	
if(username != null){ //consider it comes from login.jsp			
	session = request.getSession(false);
	
	DBCon dbCon = DBCon.getto();
	int userId = dbCon.getUserIdByName(username);		
	
	if (session == null) {			    
	    session = request.getSession();				    				
	}			
	session.setAttribute("username", username);
    session.setAttribute("XYZ", "XYZ");
	session.setAttribute("userid", ""+userId);			
	
	// set the session time out to 30 mintues
	session.setMaxInactiveInterval(30 * 60); //in seconds
	
	response.sendRedirect("dashboard.jsp");
}
else
{
	out.print("ss");
	//response.sendRedirect("index.jsp");	
}
%>			
