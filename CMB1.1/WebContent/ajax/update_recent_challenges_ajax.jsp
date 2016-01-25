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
// dataId:dataId, dataText:htmlString

String entryIdString = request.getParameter("dataId");
int entryId = -1;

if(entryIdString != null){
	entryId = Integer.parseInt(entryIdString);
}

String entryName = request.getParameter("dataText");

DBCon dbCon = DBCon.getto();
int userid = Integer.parseInt((String) session.getAttribute("userid"));
int rowsUpdated = dbCon.updateEntryNameByEntryId(entryId, entryName);

if(rowsUpdated > 0){
	%>
	<div class="alert alert-success" role="alert"><strong>Success!</strong> Challenge updated successfully.</div>
	<%	
}else {
	%>
	<div class="alert alert-danger" role="alert"><strong>Something wrong!</strong> Not updated</div>
	<%
}
%>


