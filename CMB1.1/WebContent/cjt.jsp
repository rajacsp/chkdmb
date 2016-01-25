<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*, csp.pojo.chkdlib.*"
    pageEncoding="ISO-8859-1"%>
<%
	out.println("current java time is : "+Timmer.getCurrentJavaTime());
	out.println("<br>current sql time is : "+Timmer.getCurrentMySqlTime());
%>			
