<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.pojo.chkdlib.*, csp.db.*, java.util.*"
    pageEncoding="ISO-8859-1"%>
<%
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");	
	
	
	
	DBCon dbCon = DBCon.getto();	
	boolean updateFlag = dbCon.checkLogin(username, password);
	
	if(updateFlag){
		response.sendRedirect("session.jsp?username="+username);
	} else{
		response.sendRedirect("index.jsp?error=1");
	}	
%>    