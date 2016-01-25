<%
session = request.getSession(false);
String XYZ = (String) session.getAttribute("XYZ");

if(XYZ == null){
	response.sendRedirect("index.jsp");
}
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*, csp.pojo.chkdlib.*"
    pageEncoding="ISO-8859-1"%>

<%
//  entryId:dataid, selectedDate:selectedDate
int entryId = Integer.parseInt(request.getParameter("entryId"));
String dateString = request.getParameter("selectedDate");

String tagName = request.getParameter("tagName");

DBCon dbCon = DBCon.getto();
int userid = Integer.parseInt((String) session.getAttribute("userid"));
int rowsUpdated = dbCon.updateEntryTimeByEntryId1(entryId, Dater.convertJSDateToMySQLDate(dateString));

if(rowsUpdated > 0){
	%>
	<div class="alert alert-success" role="alert"><strong>Success!</strong>Deadline added successfully</div>
	<%	
}else {
	%>
	<div class="alert alert-danger" role="alert"><strong>Something wrong!</strong> Not tagged</div>
	<%
}
%>

