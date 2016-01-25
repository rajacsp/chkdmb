<%
session = request.getSession(false);
String XYZ = (String) session.getAttribute("XYZ");

if(XYZ == null){
	response.sendRedirect("index.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*"
    pageEncoding="ISO-8859-1"%>

<%
int userId = Integer.parseInt((String) session.getAttribute("userid"));
String entryName = request.getParameter("activity");	
DBCon dbCon = DBCon.getto();
boolean insertFlag = dbCon.insertEntry(userId, entryName, "None");

if(insertFlag){
	%>
	<div class="alert alert-success" role="alert"><strong>Congrats!</strong> Your activity has been added.</div>
	<%	
}else{
	%>
	<div class="alert alert-danger" role="alert"><strong>Error!</strong> Your activity could not be added.</div>
	<%
}
%>





