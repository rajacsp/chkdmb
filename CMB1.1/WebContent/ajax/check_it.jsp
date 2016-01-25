<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.pojo.chkdlib.*, csp.db.*, java.util.*"
    pageEncoding="ISO-8859-1"%>
<%
	session = request.getSession(false);
	String XYZ = (String) session.getAttribute("XYZ");
	if(XYZ == null){
		response.sendRedirect("index.jsp");
	}
	
	int userId = Integer.parseInt((String) session.getAttribute("userid"));	
	DBCon dbCon = DBCon.getto();
	
	int entryId = Integer.parseInt(request.getParameter("entryId"));
	
	int update = dbCon.checkEntry(entryId, userId);	
%>    
<div class="alert alert-success" role="alert"><strong>Congrats!</strong> You finished your challenge successfully!!</div>