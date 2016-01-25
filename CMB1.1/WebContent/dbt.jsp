<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.DBCon"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DB Test</title>
</head>
<body>
	<%
		String dbCon = DBCon.connectionTest();
	
		out.println(dbCon);
	%>
</body>
</html>