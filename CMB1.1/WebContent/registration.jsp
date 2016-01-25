<%@ include file="header.jsp" %>
	
<%
session = request.getSession(false);
String XYZ = (String) session.getAttribute("XYZ");
if(XYZ == null){				
	%>
    <!-- container -->
    <div class="container">

		<form id="registration_form" name="registration_form" method="post" action="RegisterUser.jsp" class="form-signin" role="form">
			<h2 class="form-signin-heading">Registration</h2>
			<input type="text" name="username" class="form-control" placeholder="type your username / email" required autofocus>
			<input type="password" name="password" class="form-control" placeholder="Password" required>
			<input type="email" name="email" class="form-control" placeholder="Email" required>
			<input type="text" name="fp_question" class="form-control" placeholder="Recovery Question" required>
			<input type="text" name="fp_answer" class="form-control" placeholder="Answer for your Recovery Question" required>
			<button class="btn btn-lg btn-primary btn-block" type="submit">SIGN IN</button>
		</form>	  
    <%
    String errorNo = request.getParameter("error");
    if(errorNo != null && (Integer.parseInt(errorNo) == 1)){
    	%>
    	<div class="alert alert-danger" role="alert"><strong></strong>Username / Password must be wrong</div>
    	<%	
    }
    %>
    </div>
    <!-- /container -->
    <%    
} else{
%>
<a href="dashboard.jsp">Go to Account</a>
<br>
<a href="kill.jsp">
	<img src="images/logout_icon.png" />
</a>
<% } %>	
	

<%@ include file="footer.jsp" %>