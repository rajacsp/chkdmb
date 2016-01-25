<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.pojo.chkdlib.*, csp.db.*, java.util.*"
    pageEncoding="ISO-8859-1"%>
<%		
	DBCon dbCon = DBCon.getto();
	
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String fpQuestion = request.getParameter("fp_question");
	String fpAnswer = request.getParameter("fp_answer");	
	
	//out.println(fpAnswer);
	int rCount = dbCon.registerUser(userName, password, email, fpQuestion, fpAnswer);
	if(rCount == 1){
		response.sendRedirect("session.jsp?username="+userName);
	}
	else
		out.println("Something went wrong");	
%>    