<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Killing Session here</title>
</head>
<body>

	
	<%
	String XYZ = (String) session.getAttribute("XYZ");
	out.println(XYZ);	
	request.getSession().invalidate();
	response.sendRedirect("index.jsp");	
	%>
	
	Session killed!!

</body>
</html>