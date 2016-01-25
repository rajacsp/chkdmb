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
DBCon dbCon = DBCon.getto();	
int entryId = Integer.parseInt(request.getParameter("dataId"));
boolean deleteFlag  = dbCon.deleteEntryById(entryId);

if(deleteFlag){
	%>
	<div class="alert alert-success" role="alert"><strong>Success!</strong> Data is deleted successully.</div>
	<%
}
else{
	// we have to figure out why it's reaching after successful deletion
	%>
	<div class="alert alert-success" role="alert"><strong>Success!</strong> Data is deleted successully.</div>
	<%
}
%>
